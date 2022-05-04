import 'package:flutter/material.dart';
import 'package:picker/common/constants/duration.dart';

class FadeRouteTransition<T> extends PageRoute<T> {
  final WidgetBuilder pageBuilder;
  final Duration? duration;
  final Duration? reverseDuration;

  FadeRouteTransition({
    required this.pageBuilder,
    required String routeName,
    Object? arguments,
    this.duration,
    this.reverseDuration,
  }) : super(
      settings: RouteSettings(
        name: routeName,
        arguments: arguments,
      ));

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: pageBuilder(context),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration =>
      duration ?? const Duration(milliseconds: routeDuration);

  @override
  Duration get reverseTransitionDuration =>
      reverseDuration ?? const Duration(milliseconds: routeDuration);

  @override
  bool get opaque => false;
}
