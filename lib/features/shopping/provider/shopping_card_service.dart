import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:waf_code_challenge/common/preferences/app_preferences_and_secure_storage.dart';
import 'package:waf_code_challenge/features/models/book_model.dart';

@singleton
class ShoppingCardService with ChangeNotifier {
  int _shoppingCardCounter = 0;
  int _shoppingCardListItemCounter = 0;
  int get shoppingCardCounter => _shoppingCardCounter;

  List<BookModel> _shoppingCardItems = [];

  int getShoppingCardCounter() {
    _getPreferencesItems();
    return _shoppingCardCounter;
  }

  void addShoppingCardCounter() {
    _shoppingCardCounter++;
    _setPreferencesItems();
    notifyListeners();
  }

  List<BookModel> getShoppingCardItems() {
    _getPreferencesItems();
    return _shoppingCardItems;
  }

  void setShoppingCardItems(BookModel item) {
    _shoppingCardItems.add(item);
    _setPreferencesItems();
    notifyListeners();
  }

  int getShoppingCardListItemCounter() {
    _getPreferencesItems();
    return _shoppingCardListItemCounter;
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
    if (AppPreferencesAndSecureStorage.getBooksInfo() != null) {
      _shoppingCardItems = AppPreferencesAndSecureStorage.getBooksInfo()!;
    }
    if (AppPreferencesAndSecureStorage.getShoppingCardListItemCounter() != null) {
      _shoppingCardListItemCounter = AppPreferencesAndSecureStorage.getShoppingCardListItemCounter()!;
    }
  }

  void _setPreferencesItems() {
    AppPreferencesAndSecureStorage.setShoppingCardCounter(_shoppingCardCounter);
    AppPreferencesAndSecureStorage.setBookInfo(_shoppingCardItems);
    AppPreferencesAndSecureStorage.setShoppingCardListItemCounter(_shoppingCardListItemCounter);
  }
}
