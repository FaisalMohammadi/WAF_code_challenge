import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waf_code_challenge/common/di/di.dart';
import 'package:waf_code_challenge/common/themes/app_theme.dart';
import 'package:waf_code_challenge/features/shopping/pages/books_list_page.dart';
import 'package:waf_code_challenge/features/shopping/provider/shopping_card_service.dart';

import 'home_page.dart';

void main() async {
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShoppingCardService>.value(
          value: locator.get<ShoppingCardService>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: context.lightThemeData(), // 👈 default theme (light)
        darkTheme: context.darkThemeData(),
        home: const BooksListPage(),
      ),
    );
  }
}
