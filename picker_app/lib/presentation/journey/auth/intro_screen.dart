import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'package:picker/presentation/common/route_transition/route_transition.dart';

extension IntroScreenTheme on ThemeData {
  TextStyle get introScreenTitle => primaryHeadlineMediumBold.copyWith(
        fontSize: dimen_30.sp,
        height: dimen_38.sp.toLineHeight(dimen_30.sp),
      );

  TextStyle get introScreenContent => primaryTitleMedium.copyWith(
        color: black6666,
        fontSize: dimen_18.sp,
        height: dimen_24.sp.toLineHeight(dimen_18.sp),
      );

  TextStyle get introScreenBtn => primaryButton.copyWith(
        color: Colors.white,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({
    Key? key,
  }) : super(key: key);

  void _onTap(BuildContext context) {
    Navigator.of(context)
        .pushReplacementFadeTransition(routeName: Screens.loginPhone);
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(AppImagesAsset.bgIntro), context);

    return Scaffold(
      appBar: MyAppBar(
        bgColor: purpleF6EE,
        height: 0.0,
        elevation: 0.0,
        customTitle: const SizedBox.shrink(),
        systemUiOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: purpleF6EE,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0.0,
            top: 0.0,
            right: 0.0,
            child: LoadAssetImage(
              AppImagesAsset.bgIntro,
            ),
          ),
          Positioned(
            left: dimen_24.w,
            right: dimen_24.w,
            bottom: context.queryPaddingBottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome onboard',
                  style: Theme.of(context).introScreenTitle,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: dimen_10.h,
                    bottom: dimen_40.h,
                  ),
                  child: Text(
                    'Vui lòng nhập số điện thoại nhân viên',
                    style: Theme.of(context).introScreenContent,
                  ),
                ),
                InkButton(
                  bgColor: purple5930,
                  height: dimen_48.h,
                  onTap: () => _onTap(context),
                  child: Text(
                    'Cùng bắt đầu nào',
                    style: Theme.of(context).introScreenBtn,
                  ),
                ),
                SizedBox(
                  height: dimen_16.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
