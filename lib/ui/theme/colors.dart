import 'package:flutter/material.dart';

class AppColors {
  // Static color constants
  static const Color primaryColor = Color(0xff4eac41);
  static const Color darkPrimaryColor = Color(0xff37912b);
  static const Color accentColor = Color(0xffbe2727);

  static ColorScheme lightScheme = const ColorScheme.light(
    primary: primaryColor,
    primaryVariant: darkPrimaryColor,
    secondary: accentColor,
  );

  static ColorScheme darkScheme = const ColorScheme.dark(
    primary: primaryColor,
    primaryVariant: darkPrimaryColor,
    secondary: accentColor,
  );
}
