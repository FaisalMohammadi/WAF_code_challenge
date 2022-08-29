import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waf_code_challenge/common/constants/book_listk.dart';
import 'package:waf_code_challenge/common/di/di.dart';
import 'package:waf_code_challenge/common/preferences/app_preferences_and_secure_storage.dart';
import 'package:waf_code_challenge/features/models/book_model.dart';
import 'package:waf_code_challenge/features/shopping/components/book_list_item.dart';
import 'package:waf_code_challenge/features/shopping/components/shopping_card_item.dart';
import 'package:waf_code_challenge/features/shopping/pages/shopping_card_page.dart';
import 'package:waf_code_challenge/features/shopping/provider/shopping_card_service.dart';

import '../../models/shopping_card_model.dart';

class BooksListPage extends StatelessWidget {
  const BooksListPage({Key? key}) : super(key: key);
  final double shoppingCardIconSize = 30;
  @override
  Widget build(BuildContext context) {
    ShoppingCardService shoppingCardService =
        Provider.of<ShoppingCardService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Badge(
              badgeColor: Theme.of(context).colorScheme.secondary,
              animationType: BadgeAnimationType.fade,
              badgeContent: Consumer<ShoppingCardService>(
                builder: (context, value, child) {
                  return Text(
                    value.getShoppingCardCounter().toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  );
                },
              ),
              position: const BadgePosition(start: 30, bottom: 30),
              child: IconButton(
                iconSize: 35,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShoppingCardPage()),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
        title: const Text("Harry Potter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
          itemCount: BookListk.books.length,
          itemBuilder: (context, index) {
            BookModel bookItem = BookListk.books[index];
            return BookListItem(
              book: bookItem,
              bookListItemAddToCardButton:
                  buildBookListItemButtom(context, bookItem),
            );
          },
        ),
      ),
    );
  }

  void bookListItemButtomOnTap(BookModel book) {
    ShoppingCardService shoppingCardService =
        locator.get<ShoppingCardService>();

    ShoppingCardModel shoppingCardModel = ShoppingCardModel(
        book: book,
        amount: shoppingCardService.getShoppingCardListItemCounter(book) + 1);

    shoppingCardService.setShoppingCardItems(shoppingCardModel);
    shoppingCardService.addShoppingCardListItemCounter();
    shoppingCardService.setShoppingCardItemsUnarranged(book);
  }

  Widget buildBookListItemButtom(BuildContext context, BookModel book) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => bookListItemButtomOnTap(book),
            child: Container(
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
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
