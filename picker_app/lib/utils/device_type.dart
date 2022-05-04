import 'package:flutter/material.dart';

bool isTablet() {
  if (WidgetsBinding.instance == null) {
    return false;
  }

  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  if (data.size.shortestSide < 550) {
    return false;
  }

  return true;
}
