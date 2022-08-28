import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waf_code_challenge/features/shopping/components/book_list_item.dart';

import '../../../common/di/di.dart';
import '../../models/book_model.dart';
import '../../models/shopping_card_model.dart';
import '../provider/shopping_card_service.dart';

class ShoppingCardItem extends StatelessWidget {
  final BookModel book;
  const ShoppingCardItem({Key? key, required this.book}) : super(key: key);
  final double shoppingCardIconSize = 30;
  final Color plusMinusIconColor = Colors.black54;
  @override
  Widget build(BuildContext context) {
    return BookListItem(
      book: book,
      bookListItemAddToCardButton:
          buildShoppingCardListItemButtom(context, book),
    );
  }

  /// ontap functionality of list item plus minus button in shopping card
  void plusMinusButtonOntap(
    BookModel bookItem,
    ShoppingCardListItemButtonTypes buttonType,
  ) {
    ShoppingCardService shoppingCardService =
        locator.get<ShoppingCardService>();

    int shoppingCardListItemCounter =
        shoppingCardService.getShoppingCardListItemCounter(book);
    int increment = 1;

    /// functionality of minus button
    if (buttonType == ShoppingCardListItemButtonTypes.addButton) {
      ShoppingCardModel shoppingCardModel = ShoppingCardModel(
          book: book, amount: shoppingCardListItemCounter + increment);
      shoppingCardService.setShoppingCardItems(shoppingCardModel);
      //shoppingCardService.addShoppingCardListItemCounter();
    }

    /// functionality of add/plus button
    if (buttonType == ShoppingCardListItemButtonTypes.minusButton) {
      if (shoppingCardListItemCounter == 0) {
        increment = 0;
      }
      ShoppingCardModel shoppingCardModel = ShoppingCardModel(
          book: book, amount: shoppingCardListItemCounter - increment);
      shoppingCardService.setShoppingCardItems(shoppingCardModel);
    }
  }

  Widget buildShoppingCardListItemPlusMinusButton(
      {required BuildContext context,
      required Icon buttonIcon,
      required void Function() onTap}) {
    return Container(
      decoration: BoxDecoration(
        color:
            Theme.of(context).buttonTheme.colorScheme!.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 45,
      width: 50,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: buttonIcon,
      ),
    );
  }

  Widget buildShoppingCardListItemButtom(BuildContext context, BookModel book) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Text(
                '${book.price.toString()} €',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                buildShoppingCardListItemPlusMinusButton(
                  context: context,
                  buttonIcon: const Icon(
                    Icons.remove,
                  ),
                  onTap: () => plusMinusButtonOntap(
                    book,
                    ShoppingCardListItemButtonTypes.minusButton,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Consumer<ShoppingCardService>(
                    builder: (context, value, child) {
                      return Text(
                        value.getShoppingCardListItemCounter(book).toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                buildShoppingCardListItemPlusMinusButton(
                  context: context,
                  buttonIcon: const Icon(
                    Icons.add,
                  ),
                  onTap: () => plusMinusButtonOntap(
                    book,
                    ShoppingCardListItemButtonTypes.addButton,
                  ),
                ),
              ],
            ),
            /* Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .buttonTheme
                    .colorScheme!
                    .primary
                    .withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 45,
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    size: shoppingCardIconSize,
                    Icons.shopping_cart,
                  ),
                  Flexible(
                    child: Text(
                      '${book.price.toString()} €',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ), */
          ],
        ),
      ),
    );
  }
}

enum ShoppingCardListItemButtonTypes {
  addButton,
  minusButton,
}
