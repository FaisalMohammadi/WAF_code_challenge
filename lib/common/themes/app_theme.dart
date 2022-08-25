import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

/// Theme data for project.
extension AppTheme on BuildContext {
  static Color primaryColor = HexColor("5A6BF2");
  
  //HexColor("27618E");
  static Color darkBlue = HexColor("27618E");
  static Color purpleBlue = HexColor("5A6BF2");
  static Color darkGreen = HexColor("13661C");
  static Color darkestBlue = HexColor("001d3d");

  /// Styles for the light theme.
  ThemeData lightThemeData() {
    return ThemeData(
      cardTheme: const CardTheme(surfaceTintColor: Colors.white),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        centerTitle: true,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 19)
      ),
      colorSchemeSeed: primaryColor,
      brightness: Brightness.light,
      primaryColorDark: darkestBlue,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: primaryColor,
        ),
      ),
    );
  }

  /// Styles for the dark theme.
  ThemeData darkThemeData() {
    return ThemeData(
      colorSchemeSeed: primaryColor,
      brightness: Brightness.light,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: primaryColor,
        ),
      ),
    );
  }
}
