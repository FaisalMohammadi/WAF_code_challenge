import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:waf_code_challenge/common/widget/custom_seperator.dart';
import 'package:waf_code_challenge/features/shopping/components/shopping_card_item.dart';
import 'package:waf_code_challenge/features/shopping/provider/shopping_card_service.dart';

import '../../../common/di/di.dart';
import '../../models/book_model.dart';
import '../../models/shopping_card_model.dart';
import '../components/book_list_item.dart';

class ShoppingCardPage extends StatelessWidget {
  const ShoppingCardPage({Key? key}) : super(key: key);

  final double shoppingCardIconSize = 30;

  @override
  Widget build(BuildContext context) {
    ShoppingCardService shoppingCardProvider =
        Provider.of<ShoppingCardService>(context);

    Size screenSize = MediaQuery.of(context).size;

    List<ShoppingCardModel> shoppingCardItems =
        shoppingCardProvider.getShoppingCardItems();
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Warenkorb",
        style: Theme.of(context).appBarTheme.titleTextStyle,
      )),
      body: shoppingCardItems.isEmpty
          ? buildEmptyShoppingCardWidget(context)
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.53,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemCount: shoppingCardItems.length,
                      itemBuilder: (context, index) {
                        ShoppingCardModel bookItem = shoppingCardItems[index];
                        return Dismissible(
                          resizeDuration: Duration(milliseconds: 500),
                          onDismissed: (DismissDirection direction) =>
                              onDisissItem(direction, bookItem),
                          direction: DismissDirection.endToStart,
                          key: ObjectKey(shoppingCardItems[index]),
                          background: const SizedBox(),
                          secondaryBackground: buildSwipeActionRight(),
                          child: ShoppingCardItem(
                              book: bookItem.book ?? BookModel()),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    height: screenSize.height * 0.17,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildPaymentOverviewSection(
                          context,
                          text: "Zwischensumme:",
                          amount: shoppingCardProvider
                              .getShoppingCardSubTotalAmount()
                              .toString(),
                        ),
                        buildPaymentOverviewSection(
                          context,
                          text: "Rabatt:",
                          amount:
                              " - ${shoppingCardProvider.getAndCountShoppingCardDiscountAmount().toString()}",
                        ),
                      ],
                    ),
                  ),
                  CustomSeparator(
                    color: Theme.of(context).dividerColor,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildPaymentOverviewSection(
                          context,
                          text: "Gesamt:",
                          amount: shoppingCardProvider.getShoppingCardTotalAmount().toString(),
                        ),
                        ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style,
                          onPressed: () {},
                          child: const Text(
                            "Zur Kasse",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  onDisissItem(
      DismissDirection dismissDirection, ShoppingCardModel itemToDismiss) {
    ShoppingCardService shoppingCardService =
        locator.get<ShoppingCardService>();
    if (dismissDirection == DismissDirection.endToStart) {
      shoppingCardService.removeItemFromShoppingCard(itemToDismiss);
    }
  }

  Widget buildSwipeActionRight() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.centerRight,
        color: Colors.redAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              size: 40,
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              "Löschen",
              style: TextStyle(fontSize: 17, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget buildEmptyShoppingCardWidget(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 100,
            color: Theme.of(context).iconTheme.color,
          ),
          Text(
            "Warenkorb ist Leer Bitte fügen sie etwas hinzu!",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildPaymentOverviewSection(BuildContext context,
      {required String text,
      required String amount,
      String currencyOrPercentSign = " €"}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          amount + currencyOrPercentSign,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
