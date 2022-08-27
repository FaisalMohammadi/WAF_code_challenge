import 'package:waf_code_challenge/features/models/book_model.dart';

import 'preferences.dart';

class AppPreferencesAndSecureStorage {
  /// gets the auth-info
  static List<BookModel>? getBooksInfo() {
    List<BookModel>? booksListFromPrefs = [];
    List<dynamic>? jsonResult =
        Preferences.getbookModel<BookModel>("books_info");

    if (jsonResult != null) {
      booksListFromPrefs = jsonResult.map<BookModel>((items) => BookModel.fromJson(items)).toList();
    }
    return booksListFromPrefs;
  }

  /// sets the auth-info
  static void setBookInfo(List<BookModel>? booksInfo) {
    Preferences.setBookModel<BookModel>("books_info", booksInfo);
  }

  // gets the username
  static int? getShoppingCardCounter() {
    return Preferences.getInt("shopping_card_counter");
  }

  static void setShoppingCardCounter(int shoppingCardCounter) {
    return Preferences.setInt("shopping_card_counter", shoppingCardCounter);
  }

  static void emptySharedPrefs() {
    Preferences.clear();
  }
}
