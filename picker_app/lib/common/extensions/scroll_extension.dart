import 'dart:io';
import 'package:flutter/material.dart';

extension MXScrollPhysicsExtension on ScrollPhysics {
  ScrollPhysics toScrollPhysics() {
    if (Platform.isIOS) {
      return const BouncingScrollPhysics();
    } else if (Platform.isAndroid) {
      return const ClampingScrollPhysics();
    }

    return const AlwaysScrollableScrollPhysics();
  }
}
