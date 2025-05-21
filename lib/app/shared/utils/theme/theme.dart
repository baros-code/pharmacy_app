import 'package:flutter/material.dart';

import 'custom_themes/appbar_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/input_decoration_theme.dart';
import 'custom_themes/progress_indicator_theme.dart';
import 'custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.green,
    primaryColorDark: Colors.grey.shade900,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.green.shade100,
    disabledColor: Color(0xFF515353),
    highlightColor: Colors.red,
    shadowColor: Colors.black.withAlpha(36),
    textTheme: TTextTheme.lightTextTheme,
    inputDecorationTheme: TInputDecorationTheme.lightInputDecorationTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    progressIndicatorTheme: TProgressIndicatorTheme.lightProgressIndicatorTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.green,
    primaryColorDark: Colors.grey.shade900,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.grey.shade900,
    disabledColor: Color(0xFF515353),
    highlightColor: Colors.red,
    shadowColor: Colors.white.withAlpha(36),
    textTheme: TTextTheme.darkTextTheme,
    inputDecorationTheme: TInputDecorationTheme.darkInputDecorationTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    progressIndicatorTheme: TProgressIndicatorTheme.darkProgressIndicatorTheme,
  );
}
