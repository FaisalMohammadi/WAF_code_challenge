import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:waf_code_challenge/common/extensions/double_extension.dart';
import 'package:waf_code_challenge/common/preferences/app_preferences_and_secure_storage.dart';
import 'package:waf_code_challenge/features/models/book_model.dart';
import 'package:waf_code_challenge/features/models/shopping_card_model.dart';

/// handles all the state of shopping card
@singleton
class ShoppingCardService with ChangeNotifier {
  int _shoppingCardCounter = 0;

  /// counter for plus and minus in shopping card page
  int _shoppingCardListItemCounter = 0;

  double _shoppingCardSubTotalAmount = 0;
  double _shoppingCardDiscountAmount = 0;

  /// list of all books in shopping card that are grouped together with the same volume
  List<ShoppingCardModel> _shoppingCardItems = [];

  /// list of all books that are not grouped together with the same volume
  List<BookModel> _shoppingCardItemsUnarranged = [];

  int getShoppingCardCounter() {
    _getPreferencesItems();
    return _shoppingCardCounter;
  }

  /// gets all books in shopping card that are grouped together with the same volume
  List<ShoppingCardModel> getShoppingCardItems() {
    _getPreferencesItems();
    return _shoppingCardItems;
  }

  /// gets all books that are not grouped together with the same volume
  List<BookModel> getShoppingCardItemsUnarranged() {
    _getPreferencesItems();
    return _shoppingCardItemsUnarranged;
  }

  /// calculates the subtotal amount in shopping card
  double getShoppingCardSubTotalAmount() {
    double totalAmount = 0;
    double bookPrice = 0;
    int bookAmount = 0;

    for (int i = 0; i < _shoppingCardItems.length; i++) {
      bookPrice = _shoppingCardItems[i].book!.price!;
      bookAmount = _shoppingCardItems[i].amount!;

      totalAmount += (bookPrice * bookAmount);
    }
    _shoppingCardSubTotalAmount = totalAmount;
    return _shoppingCardSubTotalAmount;
  }

  /// calculates the discount amount in shopping card
  double getAndCountShoppingCardDiscountAmount() {
    _getPreferencesItems();

    _shoppingCardSubTotalAmount;
    double finalDiscountAmount = 0;

    // Anzahl der gleichen buch bänder
    List<double> sameBookVolumAmount = [];

    // anzahl der bücher der gleichen bänder haben
    int amountOfDifferentBooksOfSameVolume = 0;

    double sumOfAllSameBookVolumes = 0;

    /// list of all prices of same volume of different books 
    List<double> ListOfPricesOfAllBooks = [];
    double bookPrice = 0;

    // seperates all the prices of same volumes of different books and all the prices of individual books  
    for (int i = 0; i < _shoppingCardItems.length; i++) {
      bookPrice = _shoppingCardItems[i].book!.price!;
      int? sameBookVolumes = _shoppingCardItems[i].amount;

      ListOfPricesOfAllBooks.add((sameBookVolumes!).toDouble() * bookPrice);

      // gets the total price of all same volumes of different books
      double sumOfSameBookVolumes =
          (sameBookVolumes - 1).toDouble() * bookPrice;
      if (sumOfSameBookVolumes > 0.0) {
        sameBookVolumAmount.add(sumOfSameBookVolumes);
      }

      // gets the amount of volumes of the same book
      if (sameBookVolumes > 1) {
        amountOfDifferentBooksOfSameVolume++;
      }
    }

    // calculates the price of all books also books with the same volumes
    double totalPriceOfAllBooks =
        ListOfPricesOfAllBooks.reduce((value, element) => value + element);

    // calculates the sum of all same volumes of different books
    if (sameBookVolumAmount.isNotEmpty) {
      sumOfAllSameBookVolumes =
          sameBookVolumAmount.reduce((value, element) => value + element);
    }

    // calculation of the total price of the individual books
    double totalPriceOfSingleBooks =
        totalPriceOfAllBooks - sumOfAllSameBookVolumes;

    /// calculation of discount of the individual books 
    double discount = _calculateDiscountAmount(
        bookAmount: _getAmountOfBooks(listOfBooks: _shoppingCardItems),
        totalPrice: totalPriceOfSingleBooks);

    /// calculation of discount of the same volumes of different books
    sumOfAllSameBookVolumes = _calculateDiscountAmount(
        bookAmount: _getAmountOfBooks(listOfBooks: sameBookVolumAmount),
        totalPrice: sumOfAllSameBookVolumes);

    finalDiscountAmount = discount + sumOfAllSameBookVolumes;
    _shoppingCardDiscountAmount =
        _shoppingCardSubTotalAmount - finalDiscountAmount;

    return _shoppingCardDiscountAmount.toPrecision(2);
  }

  /// generic method for getting the amount of elements in shopping card based of provided list
  AmountOfBooks _getAmountOfBooks<T>({required List<T> listOfBooks}) {
    if (listOfBooks.length >= 5) {
      return AmountOfBooks.fiveOrBigger;
    } else if (listOfBooks.length == 4) {
      return AmountOfBooks.four;
    } else if (listOfBooks.length == 3) {
      return AmountOfBooks.three;
    } else {
      return AmountOfBooks.twoOrSmaller;
    }
  }

  ///
  double _calculateDiscountAmount(
      {required AmountOfBooks bookAmount, required double totalPrice}) {
    switch (bookAmount) {
      // calculation of 25 % discount
      case AmountOfBooks.fiveOrBigger:
        return _calculatePercentage(totalPrice: totalPrice, percentage: 25);

      // calculation of 20 % discount
      case AmountOfBooks.four:
        return _calculatePercentage(totalPrice: totalPrice, percentage: 20);

      // calculation of 10 % discount
      case AmountOfBooks.three:
        return _calculatePercentage(totalPrice: totalPrice, percentage: 10);

      // calculation of 5 % discount
      case AmountOfBooks.twoOrSmaller:
        return _calculatePercentage(totalPrice: totalPrice, percentage: 5);
      default:
    }
    return 0;
  }

  /// calculates the discount based on the given percentage
  double _calculatePercentage({
    required double totalPrice,
    required int percentage,
  }) {
    return totalPrice - (totalPrice / 100) * percentage;
  }

  /// gets and calculates the total amount of shopping card
  double getShoppingCardTotalAmount() {
    _getPreferencesItems();
    return _shoppingCardSubTotalAmount - _shoppingCardDiscountAmount;
  }

  /// creates the list of all books that are grouped together with the same volume in shopping card
  void setShoppingCardItems(ShoppingCardModel item) {
    if (item.amount == 0) {
      removeItemFromShoppingCard(item);
    } else if (_shoppingCardItems.any((element) => element.book == item.book)) {
      int index =
          _shoppingCardItems.indexWhere((element) => element.book == item.book);
      _shoppingCardItems[index] = item;
    } else {
      _shoppingCardCounter++;
      _shoppingCardItems.add(item);
    }
    _setPreferencesItems();
    notifyListeners();
  }

  /// remove a specific item from the shopping card
  void removeItemFromShoppingCard(ShoppingCardModel item) {
    _shoppingCardItems.removeWhere((element) => element.book == item.book);
    _shoppingCardCounter--;
    _setPreferencesItems();
    notifyListeners();
  }

  /// creates the list of all books that are not grouped together with the same volume
  void setShoppingCardItemsUnarranged(BookModel item) {
    _shoppingCardItemsUnarranged.add(item);
    _setPreferencesItems();
    notifyListeners();
  }

  /// gets the amount of volumes of the same book in shopping card
  int getShoppingCardListItemCounter(BookModel bookItem) {
    _getPreferencesItems();
    if (_shoppingCardItems.isNotEmpty) {
      int? counter = _shoppingCardItems
          .firstWhere((element) => element.book == bookItem,
              orElse: () => ShoppingCardModel(amount: null))
          .amount;

      return counter ?? 0;
    } else {
      return 0;
    }
  }

  /// subtract/decreases the book volume of the same book in shopping card by clicking the minus buttton
  void addShoppingCardListItemCounter() {
    _shoppingCardListItemCounter++;
    _setPreferencesItems();
    notifyListeners();
  }

  /// adds/increases the book volume of the same book in shopping card by clicking the minus buttton
  void subtractShoppingCardListItemCounter() {
    _shoppingCardListItemCounter--;
    _setPreferencesItems();
    notifyListeners();
  }

  /// gets all the saved values from shared preferences
  void _getPreferencesItems() {
    if (AppPreferencesAndSecureStorage.getShoppingCardCounter() != null) {
      _shoppingCardCounter =
          AppPreferencesAndSecureStorage.getShoppingCardCounter()!;
    }

    if (AppPreferencesAndSecureStorage.getBooksInfoUnarranged() != null) {
      _shoppingCardItemsUnarranged =
          AppPreferencesAndSecureStorage.getBooksInfoUnarranged()!;
    }

    if (AppPreferencesAndSecureStorage.getBooksInfo() != null) {
      _shoppingCardItems = AppPreferencesAndSecureStorage.getBooksInfo()!;
    }

    if (AppPreferencesAndSecureStorage.getShoppingCardListItemCounter() !=
        null) {
      _shoppingCardListItemCounter =
          AppPreferencesAndSecureStorage.getShoppingCardListItemCounter()!;
    }
  }

  /// saves values in shared preferences
  void _setPreferencesItems() {
    AppPreferencesAndSecureStorage.setShoppingCardCounter(_shoppingCardCounter);

    AppPreferencesAndSecureStorage.setBookInfo(_shoppingCardItems);
    AppPreferencesAndSecureStorage.setBookInfoUnarranged(
        _shoppingCardItemsUnarranged);

    AppPreferencesAndSecureStorage.setShoppingCardListItemCounter(
        _shoppingCardListItemCounter);
  }
}

/// used to identify the amount of books in shopping card
/// for calculating with different discount percentages
enum AmountOfBooks {
  fiveOrBigger,
  four,
  three,
  twoOrSmaller,
}
