import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppConstants.backgroundColor,
    primaryColor: AppConstants.primaryColor,
    colorScheme: ColorScheme.dark(
      primary: AppConstants.primaryColor,
      secondary: AppConstants.accentColor,
      surface: AppConstants.surfaceColor,
    ),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppConstants.textPrimary,
        letterSpacing: -1.0,
      ),
      headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppConstants.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        color: AppConstants.textSecondary,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppConstants.textSecondary,
        height: 1.5,
      )
    )
  );
}