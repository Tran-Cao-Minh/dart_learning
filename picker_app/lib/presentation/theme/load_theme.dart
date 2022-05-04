import 'package:flutter/material.dart';

import 'theme_color.dart';
import 'theme_constants.dart';
import 'theme_input_decoration.dart';
import 'package:picker/common/common.dart';

ThemeData loadTheme(BuildContext context) {
  return ThemeData(
    primaryColor: white,
    primaryColorLight: white,
    primaryColorDark: white,
    backgroundColor: white,
    scaffoldBackgroundColor: white,
    iconTheme: const IconThemeData(
      color: black3333,
    ),
    primarySwatch: purple5930.swatch,
    primaryTextTheme: primaryTextTheme,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: blue1976,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: black3333,
      ),
    ),
    inputDecorationTheme: primaryTextInputDecorationTheme,
  );
}
