import 'package:flutter/material.dart';
import 'package:picker/presentation/routes.dart';

import 'fade_transition.dart';
import 'slide_transition.dart';

enum TransitionType { ttb, btt, rtl }

extension NavigatorExtension on NavigatorState {
  Future<T?> pushFadeTransition<T>({
    required String routeName,
    Object? arguments,
    Duration? duration,
    Duration? reverseDuration,
  }) {
    return push<T>(
      FadeRouteTransition<T>(
        pageBuilder: Routes.allRoutes(context)[routeName]!,
        routeName: routeName,
        arguments: arguments,
        duration: duration,
        reverseDuration: reverseDuration,
      ),
    );
  }

  Future<T?> pushReplacementFadeTransition<T, S>({
    required String routeName,
    Object? arguments,
    Duration? duration,
    Duration? reverseDuration,
  }) {
    return pushReplacement<T, S>(
      FadeRouteTransition<T>(
        pageBuilder: Routes.allRoutes(context)[routeName]!,
        routeName: routeName,
        arguments: arguments,
        duration: duration,
        reverseDuration: reverseDuration,
      ),
    );
  }

  Future<T?> pushBTTTransition<T>({
    required String routeName,
    Object? arguments,
    Duration? duration,
    Duration? reverseDuration,
  }) {
    return push<T>(
      SlideRouteTransition<T>(
        pageBuilder: Routes.allRoutes(context)[routeName]!,
        routeName: routeName,
        arguments: arguments,
        duration: duration,
        reverseDuration: reverseDuration,
        type: TransitionType.btt,
      ),
    );
  }

  Future<T?> pushReplacementBTTTransition<T, S>({
    required String routeName,
    Object? arguments,
    Duration? duration,
    Duration? reverseDuration,
  }) {
    return pushReplacement<T, S>(
      SlideRouteTransition<T>(
        pageBuilder: Routes.allRoutes(context)[routeName]!,
        routeName: routeName,
        arguments: arguments,
        duration: duration,
        reverseDuration: reverseDuration,
        type: TransitionType.btt,
      ),
    );
  }

  Future<T?> pushTTBTransition<T>({
    required String routeName,
    Object? arguments,
    Duration? duration,
    Duration? reverseDuration,
    Offset? beginOffset,
  }) {
    return push<T>(
      SlideRouteTransition<T>(
        pageBuilder: Routes.allRoutes(context)[routeName]!,
        routeName: routeName,
        arguments: arguments,
        duration: duration,
        reverseDuration: reverseDuration,
        type: TransitionType.ttb,
      ),
    );
  }

  Future<T?> pushReplacementTTBTransition<T, S>({
    required String routeName,
    Object? arguments,
    Duration? duration,
    Duration? reverseDuration,
  }) {
    return pushReplacement<T, S>(
      SlideRouteTransition<T>(
        pageBuilder: Routes.allRoutes(context)[routeName]!,
        routeName: routeName,
        arguments: arguments,
        duration: duration,
        reverseDuration: reverseDuration,
        type: TransitionType.ttb,
      ),
    );
  }

  Future<T?> pushRTLTransition<T>({
    required String routeName,
    Object? arguments,
    Duration? duration,
    Duration? reverseDuration,
    Offset? beginOffset,
  }) {
    return push<T>(
      SlideRouteTransition<T>(
        pageBuilder: Routes.allRoutes(context)[routeName]!,
        routeName: routeName,
        arguments: arguments,
        duration: duration,
        reverseDuration: reverseDuration,
        type: TransitionType.rtl,
      ),
    );
  }

  Future<T?> pushReplacementRTLTransition<T, S>({
    required String routeName,
    Object? arguments,
    Duration? duration,
    Duration? reverseDuration,
  }) {
    return pushReplacement<T, S>(
      SlideRouteTransition<T>(
        pageBuilder: Routes.allRoutes(context)[routeName]!,
        routeName: routeName,
        arguments: arguments,
        duration: duration,
        reverseDuration: reverseDuration,
        type: TransitionType.rtl,
      ),
    );
  }
}
