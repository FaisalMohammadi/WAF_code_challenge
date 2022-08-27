import 'package:waf_code_challenge/common/constants/assets.gen.dart';
import 'package:waf_code_challenge/features/models/book_model.dart';

class BookListk {
  static const double _price = 8.0;
  static const String _author = "J.K. Rowling";
  static List<BookModel> books = [
    BookModel(
      price: _price,
      title: "Harry Potter and the Philosopher's Stone",
      bookVolume: 1,
      imagePath: Assets.pictures.harrypotterB1.path,
      author: _author,
    ),
    BookModel(
      price: _price,
      title: "Harry Potter and the Chamber of Secrets",
      bookVolume: 2,
      imagePath: Assets.pictures.harrypotterB2.path,
      author: _author,
    ),
    BookModel(
      price: _price,
      title: "Harry Potter and the Prisoner of Azkaban",
      bookVolume: 3,
      imagePath: Assets.pictures.harrypotterB3.path,
      author: _author,
    ),
    BookModel(
      price: _price,
      title: "Harry Potter and the Goblet of Fire",
      bookVolume: 4,
      imagePath: Assets.pictures.harrypotterB4.path,
      author: _author,
    ),
    BookModel(
      price: _price,
      title: "Harry Potter and the Order of the Phoenix",
      bookVolume: 5,
      imagePath: Assets.pictures.harrypotterB5.path,
      author: _author,
    ),
  ];
}
