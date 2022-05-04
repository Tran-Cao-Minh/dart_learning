import 'dart:ui';
import 'device_type.dart';

// FONT SCALE
final physicalScreenSize = window.physicalSize;
final pixelRatio = window.devicePixelRatio;
final logicalScreenSize = window.physicalSize / pixelRatio;
final logicalWidth = logicalScreenSize.width;
final double scale = logicalWidth / 375;

double normalize(double size) {
  if (isTablet()) {
    return size;
  }
  final newSize = size * scale;
  return newSize.roundToDouble();
}
