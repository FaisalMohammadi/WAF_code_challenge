import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
      cardTheme: const CardTheme(surfaceTintColor: Colors.white),
      appBarTheme: AppBarTheme(
          color: primaryColor,
          centerTitle: true,
          actionsIconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
          iconTheme: IconThemeData(color: Colors.white)),
      iconTheme: IconThemeData(
        color: primaryColor,
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
  ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      colorSchemeSeed: darkestBlue,
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
