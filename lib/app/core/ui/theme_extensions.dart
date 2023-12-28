import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  Color get myCustomPrimaryColor => Color.fromARGB(255, 178, 182, 205);
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get elevateseButtonColor => Color.fromARGB(255, 102, 120, 219);
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle get titleStyle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: myCustomPrimaryColor,
      );
  ButtonStyle? get elevatedButtonThemeCustom => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        textStyle: MaterialStateProperty.all<TextStyle>(titleStyle),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
}
