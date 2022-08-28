// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:waf_code_challenge/features/models/book_model.dart';

class ShoppingCardModel {
  final BookModel? book;
  final int? amount;
  ShoppingCardModel({
    this.book,
    required this.amount,
  });


  ShoppingCardModel copyWith({
    BookModel? book,
    int? amount,
  }) {
    return ShoppingCardModel(
      book: book ?? this.book,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'book': book?.toMap(),
      'amount': amount,
    };
  }

  factory ShoppingCardModel.fromMap(Map<String, dynamic> map) {
    return ShoppingCardModel(
      book: map['book'] != null ? BookModel.fromMap(map['book'] as Map<String,dynamic>) : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCardModel.fromJson(String source) => ShoppingCardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ShoppingCardModel(book: $book, amount: $amount)';

  @override
  bool operator ==(covariant ShoppingCardModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.book == book &&
      other.amount == amount;
  }

  @override
  int get hashCode => book.hashCode ^ amount.hashCode;
}
