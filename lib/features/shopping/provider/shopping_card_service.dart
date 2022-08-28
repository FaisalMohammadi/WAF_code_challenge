import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:waf_code_challenge/common/preferences/app_preferences_and_secure_storage.dart';
import 'package:waf_code_challenge/features/models/book_model.dart';
import 'package:waf_code_challenge/features/models/shopping_card_model.dart';
import 'package:waf_code_challenge/features/shopping/components/shopping_card_item.dart';

@singleton
class ShoppingCardService with ChangeNotifier {
  int _shoppingCardCounter = 0;
  int _shoppingCardListItemCounter = 0;
  int get shoppingCardCounter => _shoppingCardCounter;

  List<ShoppingCardModel> _shoppingCardItems = [];
  List<BookModel> _shoppingCardItemsUnarranged = [];

  int getShoppingCardCounter() {
    _getPreferencesItems();
    return _shoppingCardCounter;
  }

  void addShoppingCardCounter() {
    _shoppingCardCounter++;
    _setPreferencesItems();
    notifyListeners();
  }

  List<ShoppingCardModel> getShoppingCardItems() {
    _getPreferencesItems();
    return _shoppingCardItems;
  }

  List<BookModel> getShoppingCardItemsUnarranged() {
    _getPreferencesItems();
    return _shoppingCardItemsUnarranged;
  }

  void setShoppingCardItems(ShoppingCardModel item) {
    if (_shoppingCardItems.any((element) => element.book == item.book)) {
      int index =
          _shoppingCardItems.indexWhere((element) => element.book == item.book);
      _shoppingCardItems[index] = item;
    } else {
      _shoppingCardItems.add(item);
    }
    _setPreferencesItems();
    notifyListeners();
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
