import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waf_code_challenge/common/constants/book_listk.dart';

import '../../models/book_model.dart';
import '../../models/shopping_card_model.dart';

class BookListItem extends StatelessWidget {
  final BookModel book;
  final Widget bookListItemAddToCardButton;

  const BookListItem(
      {Key? key, required this.book, required this.bookListItemAddToCardButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 8), //EdgeInsets.only(left: 10, right: 10,top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .secondary
                      .withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(
                      5,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    book.bookVolume.toString(),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 30,
                    blurRadius: 30,
                    offset: const Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
              height: 150,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Image.asset(book.imagePath!),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              textAlign: TextAlign.start,
                              book.title!,
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${book.author}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        bookListItemAddToCardButton,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;

  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, size.height * 0.0045);
    path0.lineTo(0, size.height);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width / 1.5, size.height * 0.0040000);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
