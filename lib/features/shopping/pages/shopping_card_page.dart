import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:waf_code_challenge/common/widget/custom_seperator.dart';
import 'package:waf_code_challenge/features/shopping/components/shopping_card_item.dart';
import 'package:waf_code_challenge/features/shopping/provider/shopping_card_service.dart';

import '../../models/book_model.dart';
import '../../models/shopping_card_model.dart';
import '../components/book_list_item.dart';

class ShoppingCardPage extends StatelessWidget {
  const ShoppingCardPage({Key? key}) : super(key: key);

  final double shoppingCardIconSize = 30;

  @override
  Widget build(BuildContext context) {
    ShoppingCardService shoppingCardProvider = Provider.of(context);

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
                    child: ListView.builder(
                      itemCount: shoppingCardItems.length,
                      itemBuilder: (context, index) {
                        ShoppingCardModel bookItem = shoppingCardItems[index];
                        return ShoppingCardItem(
                            book: bookItem.book ?? BookModel());
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    height: screenSize.height * 0.17,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildPaymentOverviewSection(
                          context,
                          text: "Zwischenzumme:",
                          amount: shoppingCardProvider.getShoppingCardTotalAmount().toString(),
                        ),
                        buildPaymentOverviewSection(
                          context,
                          text: "Rabatt:",
                          amount: "- 20", // TODO
                        ),
                        buildPaymentOverviewSection(
                          context,
                          text: "Mwst:",
                          amount: "+ 19", // TODO
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
                          amount: "300", // TODO
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
      {required String text, required String amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "$amount €",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
