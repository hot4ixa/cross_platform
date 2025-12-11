import 'package:flutter/material.dart';
import 'theme_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ThemeColors.white,
      colorScheme: _colorScheme,
      appBarTheme: _appBarTheme,
      // таким же образом сюда можно добавить и темы других виджетов
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ThemeColors.black_2,
      appBarTheme: _appBarTheme,
      textTheme: _textTheme,
    );
  }
}

final _colorScheme = ColorScheme.fromSeed(
  seedColor: ThemeColors.accent,
);


final _textTheme = TextTheme(
  bodyMedium: TextStyle(
    fontFamily: "Arial",
    fontSize: 14,
    color: ThemeColors.yellow,
  ),
  titleLarge: TextStyle(
    fontFamily: "Arial",
    fontSize: 20,
    color: ThemeColors.brown,
  ),
  labelSmall: TextStyle(
    fontFamily: "Arial",
    fontSize: 14,
    color: ThemeColors.orange,
  ),
  headlineLarge: TextStyle(
    fontFamily: "Arial",
    fontSize: 15,
    color: ThemeColors.orange,
  ),
  labelLarge: TextStyle(
    fontFamily: "Arial",
    fontSize: 25,
    color: ThemeColors.yellow,
  ),
);


final _appBarTheme = AppBarTheme(
  toolbarHeight: 50,
  elevation: 0,
  scrolledUnderElevation: 0,
  centerTitle: true,
  titleTextStyle: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: ThemeColors.orange,
  ),
  backgroundColor: ThemeColors.black,
  shape: Border(
            bottom: BorderSide(
              color: ThemeColors.borderColor.withAlpha(1),
              width: 2,
            ),
  ),
);
