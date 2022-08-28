import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:waf_code_challenge/common/preferences/app_preferences_and_secure_storage.dart';
import 'package:waf_code_challenge/features/models/book_model.dart';
import 'package:waf_code_challenge/features/models/shopping_card_model.dart';

@singleton
class ShoppingCardService with ChangeNotifier {
  int _shoppingCardCounter = 0;
  int _shoppingCardListItemCounter = 0;
  int get shoppingCardCounter => _shoppingCardCounter;
  double _shoppingCardTotalAmount = 0;

  List<ShoppingCardModel> _shoppingCardItems = [];
  List<BookModel> _shoppingCardItemsUnarranged = [];

  int getShoppingCardCounter() {
    _getPreferencesItems();
    return _shoppingCardCounter;
  }

  List<ShoppingCardModel> getShoppingCardItems() {
    _getPreferencesItems();
    return _shoppingCardItems;
  }

  List<BookModel> getShoppingCardItemsUnarranged() {
    _getPreferencesItems();
    return _shoppingCardItemsUnarranged;
  }

  double getShoppingCardTotalAmount() {
    double totalAmount = 0;
    double bookPrice = 0;
    int bookAmount = 0;

    for (int i = 0; i < _shoppingCardItems.length; i++) {
      bookPrice = _shoppingCardItems[i].book!.price!;
      bookAmount = _shoppingCardItems[i].amount!;

      totalAmount += (bookPrice * bookAmount);
    }
    _shoppingCardTotalAmount = totalAmount;
    return _shoppingCardTotalAmount;
  }

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

  void removeItemFromShoppingCard(ShoppingCardModel item) {
    _shoppingCardItems.removeWhere((element) => element.book == item.book);
    _shoppingCardCounter--;
  }

  void setShoppingCardItemsUnarranged(BookModel item) {
    _shoppingCardItemsUnarranged.add(item);
    _setPreferencesItems();
    notifyListeners();
  }

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

  void addShoppingCardListItemCounter() {
    _shoppingCardListItemCounter++;
    _setPreferencesItems();
    notifyListeners();
  }

  void subtractShoppingCardListItemCounter() {
    _shoppingCardListItemCounter--;
    _setPreferencesItems();
    notifyListeners();
  }

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

  void _setPreferencesItems() {
    AppPreferencesAndSecureStorage.setShoppingCardCounter(_shoppingCardCounter);

    AppPreferencesAndSecureStorage.setBookInfo(_shoppingCardItems);
    AppPreferencesAndSecureStorage.setBookInfoUnarranged(
        _shoppingCardItemsUnarranged);

    AppPreferencesAndSecureStorage.setShoppingCardListItemCounter(
        _shoppingCardListItemCounter);
  }
}
