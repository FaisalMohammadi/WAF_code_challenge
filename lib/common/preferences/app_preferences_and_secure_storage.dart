import 'package:waf_code_challenge/features/models/book_model.dart';

import '../../features/models/shopping_card_model.dart';
import 'preferences.dart';

class AppPreferencesAndSecureStorage {
  /// gets the auth-info
  static List<BookModel>? getBooksInfoUnarranged() {
    List<BookModel>? booksListFromPrefs = [];
    List<dynamic>? jsonResult =
        Preferences.getbookModel<BookModel>("books_info_unarranged");

    if (jsonResult != null) {
      booksListFromPrefs = jsonResult
          .map<BookModel>((items) => BookModel.fromJson(items))
          .toList();
    }
    return booksListFromPrefs;
  }

  static List<ShoppingCardModel>? getBooksInfo() {
    List<ShoppingCardModel>? booksListFromPrefs = [];
    List<dynamic>? jsonResult =
        Preferences.getbookModel<BookModel>("books_info");

    if (jsonResult != null) {
      booksListFromPrefs = jsonResult
          .map<ShoppingCardModel>((items) => ShoppingCardModel.fromJson(items))
          .toList();
    }
    return booksListFromPrefs;
  }

  static void setBookInfo(List<ShoppingCardModel>? booksInfo) {
    Preferences.setBookModel<ShoppingCardModel>("books_info", booksInfo);
  }

  static void setBookInfoUnarranged(List<BookModel>? booksInfo) {
    Preferences.setBookModel<BookModel>("books_info_unarranged", booksInfo);
  }

  static int? getShoppingCardCounter() {
    return Preferences.getInt("shopping_card_counter");
  }

  static void setShoppingCardCounter(int shoppingCardCounter) {
    return Preferences.setInt("shopping_card_counter", shoppingCardCounter);
  }

  static void setShoppingCardListItemCounter(int shoppingCardCounter) {
    return Preferences.setInt(
        "shopping_card_list_item_counter", shoppingCardCounter);
  }

  static int? getShoppingCardListItemCounter() {
    return Preferences.getInt("shopping_card_list_item_counter");
  }

  static void emptySharedPrefs() {
    Preferences.clear();
  }
}
