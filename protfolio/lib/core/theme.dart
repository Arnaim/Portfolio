import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppConstants.backgroundColor,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppConstants.textPrimary
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppConstants.textSecondary
      )
    )
  );
}