import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/blocs/blocs.dart';
import 'package:picker/presentation/journey/auth/forgot_password_screen.dart';
import 'package:picker/presentation/journey/auth/intro_screen.dart';
import 'package:picker/presentation/journey/auth/verify_otp_screen.dart';
import 'package:picker/presentation/journey/auth/login/login_password_screen.dart';
import 'package:picker/presentation/journey/auth/login/login_phone_screen.dart';
import 'package:picker/presentation/journey/home/home_screen.dart';

import 'splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> allRoutes(BuildContext context) {
    return {
      Screens.splash: (_) => const SplashScreen(),
      Screens.intro: (_) => const IntroScreen(),
      Screens.loginPhone: (_) {
        return BlocProvider<LoginBloc>(
          create: (_) => LoginBloc.instance(),
          child: const LoginPhoneScreen(),
        );
      },
      Screens.loginPassword: (_) {
        return BlocProvider<LoginBloc>.value(
          value: EventBus().blocFromKey<LoginBloc>(Keys.Blocs.loginBloc)!,
          child: const LoginPasswordScreen(),
        );
      },
      Screens.verifyOTP: (context) {
        final arguments = asT<Map<String, dynamic>>(
                ModalRoute.of(context)?.settings.arguments) ??
            {};
        final String phoneNumber = arguments[Keys.AuthJourney.phoneNumber];

        return BlocProvider<VerifyOTPBloc>(
          create: (_) => VerifyOTPBloc.instance(),
          child: VerifyOTPScreen(
            phoneNumber: phoneNumber,
          ),
        );
      },
      Screens.forgotPassword: (context) {
        final arguments = asT<Map<String, dynamic>>(
                ModalRoute.of(context)?.settings.arguments) ??
            {};
        final String otpCode = arguments[Keys.AuthJourney.otpCode];

        return BlocProvider<ForgotPasswordBloc>(
          create: (_) => ForgotPasswordBloc.instance(),
          child: ForgotPasswordScreen(
            otpCode: otpCode,
          ),
        );
      },
      Screens.home: (context) {
        return HomeScreen();
      }
    };
  }
}
