import 'package:flutter/material.dart';
import 'package:picker/common/constants/duration.dart';

import 'route_transition.dart';

class SlideRouteTransition<T> extends PageRoute<T> {
  final WidgetBuilder pageBuilder;
  final Duration? duration;
  final Duration? reverseDuration;
  final TransitionType type;

  SlideRouteTransition({
    required this.pageBuilder,
    required String routeName,
    Object? arguments,
    this.duration,
    this.reverseDuration,
    required this.type,
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
  bool get opaque => false;

  @override
  final bool barrierDismissible = false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder(context);
  }

  Offset get _beginOffset {
    switch (type) {
      case TransitionType.ttb:
        return const Offset(0, 1);
      case TransitionType.btt:
        return const Offset(0, -1);
      case TransitionType.rtl:
        return const Offset(1, 0);
    }
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: _beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        curve: Curves.easeIn,
        parent: animation,
      )),
      child: child,
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
}
