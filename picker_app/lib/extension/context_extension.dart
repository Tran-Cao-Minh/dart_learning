import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextCommonExtension on BuildContext {
  bool hasBloc<T extends Bloc>() {
    try {
      final _ = BlocProvider.of<T>(this);
      return true;
    } catch (_) {}
    return false;
  }
}