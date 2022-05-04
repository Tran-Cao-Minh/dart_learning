import 'package:flutter/material.dart';
import 'theme_constants.dart';

extension TextThemeData on ThemeData {
  // Primary style
  TextStyle get primaryHeadlineLarge => primaryTextTheme.headline3!;
  TextStyle get primaryHeadlineLargeBold =>
      primaryTextTheme.headline3!.copyWith(
        fontWeight: FontWeight.w500,
      );
  TextStyle get primaryHeadlineMedium => primaryTextTheme.headline4!;
  TextStyle get primaryHeadlineMediumBold =>
      primaryTextTheme.headline4!.copyWith(
        fontWeight: FontWeight.w500,
      );
  TextStyle get primaryNumber => primaryTextTheme.headline5!;
  TextStyle get primaryHeader => primaryTextTheme.headline6!;
  TextStyle get primaryButton => primaryTextTheme.button!;
  TextStyle get primaryButtonBold => primaryTextTheme.button!.copyWith(
        fontWeight: FontWeight.w500,
      );
  TextStyle get primaryTitleLarge => primaryTextTheme.headline6!;
  TextStyle get primaryTitleMedium => primaryTextTheme.subtitle1!;
  TextStyle get primaryBodyMedium => primaryTextTheme.bodyText1!;
  TextStyle get primaryBodyMediumBold => primaryTextTheme.bodyText1!.copyWith(
        fontWeight: FontWeight.w500,
      );
  TextStyle get primaryBodySmall => primaryTextTheme.bodyText2!;
  TextStyle get primaryCaption => primaryTextTheme.caption!;

  // Secondary style

  // Accent style
}
