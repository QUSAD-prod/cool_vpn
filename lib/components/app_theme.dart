import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    typography: Typography.material2021(),
    primarySwatch: Colors.lightBlue,
    scaffoldBackgroundColor: AppColors.lightThemeBackgroundColor,
    splashFactory: InkRipple.splashFactory,
    // highlightColor: Colors.transparent,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    typography: Typography.material2021(),
    primarySwatch: Colors.lightBlue,
    scaffoldBackgroundColor: AppColors.darkThemeBackgroundColor,
    splashFactory: InkRipple.splashFactory,
    // highlightColor: Colors.transparent,
  );

  static ThemeMode getThemeMode(String hiveThemeMode) {
    switch (hiveThemeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }
}
