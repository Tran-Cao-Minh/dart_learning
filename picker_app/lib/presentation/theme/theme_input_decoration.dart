import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'theme_color.dart';

InputDecorationTheme primaryTextInputDecorationTheme =
    const InputDecorationTheme(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: dimen_1,
      style: BorderStyle.solid,
      color: blue1976,
    ),
    borderRadius: BorderRadius.all(Radius.circular(dimen_8)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: dimen_1,
      style: BorderStyle.solid,
      color: redE70D,
    ),
    borderRadius: BorderRadius.all(Radius.circular(dimen_8)),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      width: dimen_1,
      style: BorderStyle.solid,
      color: blackCCCC,
    ),
    borderRadius: BorderRadius.all(Radius.circular(dimen_8)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: dimen_1,
      style: BorderStyle.solid,
      color: blackCCCC,
    ),
    borderRadius: BorderRadius.all(Radius.circular(dimen_8)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: redE70D,
      width: dimen_1,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.all(Radius.circular(dimen_8)),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: dimen_1,
      style: BorderStyle.solid,
      color: blackCCCC,
    ),
    borderRadius: BorderRadius.all(Radius.circular(dimen_8)),
  ),
);
