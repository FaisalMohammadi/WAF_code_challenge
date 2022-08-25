import 'package:flutter/material.dart';
import 'package:waf_code_challenge/common/themes/app_theme.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.lightThemeData(), // 👈 default theme (light)
      darkTheme: context.darkThemeData(),
      home: const MyHomePage(title: 'Harrypotter'),
    );
  }
}


