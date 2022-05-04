import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:picker/presentation/journey/home_screen/home_screen.dart';
import 'package:picker/screens/forget_password/forget_password_screen.dart';
import 'package:picker/screens/order/confirm_new_order_screen.dart';
import 'package:picker/screens/order_history/order_history_screen.dart';
import 'package:picker/screens/picking_summary/picking_summary_screen.dart';
import 'package:picker/screens/place_order_completed/place_order_completed_screen.dart';
import 'route_constant.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.homeRoute:
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(milliseconds: 300),
          settings: settings,
        );
      // case RouteConstant.signIn:
      //   return PageTransition(
      //     child: const AuthScreen(),
      //     type: PageTransitionType.fade,
      //     duration: const Duration(milliseconds: 300),
      //     reverseDuration: const Duration(milliseconds: 300),
      //     settings: settings,
      //   );
      // case RouteConstant.authOTP:
      //   return PageTransition(
      //     child: const AuthOTPScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     duration: const Duration(milliseconds: 500),
      //     reverseDuration: const Duration(milliseconds: 500),
      //     settings: settings,
      //   );
      // case RouteConstant.authPassword:
      //   return PageTransition(
      //     child: const AuthPasswordScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     duration: const Duration(milliseconds: 500),
      //     reverseDuration: const Duration(milliseconds: 500),
      //     settings: settings,
      //   );
      case RouteConstant.forgetPassword:
        return PageTransition(
          child: const ForgetPasswordScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case RouteConstant.orderHistory:
        return PageTransition(
          child: const OrderHistoryScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case RouteConstant.confirmNewOrder:
        return PageTransition(
          child: const ConfirmNewOrderScreen(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case RouteConstant.pickingSummary:
        return PageTransition(
          child: const PickingSummaryScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case RouteConstant.placeOrderCompleted:
        return PageTransition(
          child: const PlaceOrderCompletedScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Root No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
