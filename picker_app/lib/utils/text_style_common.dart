import 'package:flutter/material.dart';
import 'constants.dart';
import 'normalize.dart';

class TextStyleCommon {
  static TextStyle displayHeaderBold(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
  }) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        fontSize:
            fontSize != null ? normalize(fontSize) : normalize(textSize16),
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color ?? Colors.black,
        height: height ?? 1,
        fontFamily: 'Roboto-Medium.ttf');
  }

  static TextStyle displayHeader(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
  }) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        fontSize:
            fontSize != null ? normalize(fontSize) : normalize(textSize18),
        fontWeight: fontWeight ?? FontWeight.w500,
        height: height ?? 1,
        color: color ?? Colors.black,
        fontFamily: 'Roboto-Medium.ttf');
  }

  static TextStyle displaySubBody(BuildContext context,
      {Color? color,
      FontWeight? fontWeight,
      double? fontSize,
      double? height}) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        fontSize:
            fontSize != null ? normalize(fontSize) : normalize(textSize14),
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
        fontFamily: 'Roboto-Regular.ttf',
        height: height ?? 1);
  }
}
