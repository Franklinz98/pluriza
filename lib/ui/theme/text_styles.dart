import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static String? get fontFamily => GoogleFonts.roboto().fontFamily;

  // Headline 1
  static TextStyle get headline1 => GoogleFonts.montserrat(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  // Headline 1
  static TextStyle get headline2 => GoogleFonts.roboto(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  // Bodytext 2
  static TextStyle get bodytext1 => GoogleFonts.roboto(
        fontSize: 14.0,
        color: Colors.black54,
      );

  // Text theme
  static TextTheme get textTheme => TextTheme(
        headline1: headline1,
        headline2: headline2,
        bodyText1: bodytext1,
      );
}
