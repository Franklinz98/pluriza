import 'package:flutter/material.dart';
import 'package:pluriza/ui/theme/text_styles.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get ligthTheme {
    return ThemeData(
      colorScheme: AppColors.lightScheme,
      fontFamily: AppTextStyle.fontFamily,
      textTheme: AppTextStyle.textTheme,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.accentColor,
        ),
      ),
    );
  }
}
