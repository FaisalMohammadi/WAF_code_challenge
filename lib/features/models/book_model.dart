// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookModel {
  final String? title;
  final String? author;
  final String? imagePath;
  final int? bookVolume;
  final double? price;
  BookModel({
    this.title,
    this.author,
    this.imagePath,
    this.bookVolume,
    this.price,
  });

  BookModel copyWith({
    String? title,
    String? author,
    String? imagePath,
    int? bookVolume,
    double? price,
  }) {
    return BookModel(
      title: title ?? this.title,
      author: author ?? this.author,
      imagePath: imagePath ?? this.imagePath,
      bookVolume: bookVolume ?? this.bookVolume,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'author': author,
      'imagePath': imagePath,
      'bookVolume': bookVolume,
      'price': price,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      title: map['title'] != null ? map['title'] as String : null,
      author: map['author'] != null ? map['author'] as String : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      bookVolume: map['bookVolume'] != null ? map['bookVolume'] as int : null,
      price: map['price'] != null ? map['price'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) => BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(title: $title, author: $author, imagePath: $imagePath, bookVolume: $bookVolume, price: $price)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.author == author &&
      other.imagePath == imagePath &&
      other.bookVolume == bookVolume &&
      other.price == price;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      author.hashCode ^
      imagePath.hashCode ^
      bookVolume.hashCode ^
      price.hashCode;
  }
}
