import 'package:waf_code_challenge/features/models/book_model.dart';

import 'preferences.dart';

class AppPreferencesAndSecureStorage {
  /// gets the auth-info
  static BookModel? getBooksInfo() {
    Map<String, dynamic> jsonResult = Preferences.getbookModel<BookModel>("books_info");
    BookModel booksInfo = BookModel.fromMap(jsonResult);
    return booksInfo;
  }

  /// sets the auth-info
  static void setBookInfo(BookModel? booksInfo) {
    Preferences.setBookModel<BookModel>("books_info", booksInfo);
  }

  // gets the username
  static int? getShoppingCardCounter() {
    return Preferences.getInt("shopping_card_counter");
  }

  static void setShoppingCardCounter(bool shoppingCardCounter) {
    return Preferences.setBool("shopping_card_counter", shoppingCardCounter);
  }
}