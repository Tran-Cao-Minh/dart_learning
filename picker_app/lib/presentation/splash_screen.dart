import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/common/route_transition/route_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context)
          .pushReplacementFadeTransition(routeName: Screens.intro);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawerEdgeDragWidth: 0.0,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: AppIcon(
            AppIcons.appLogo,
          ),
        ),
      ),
    );
  }
}
