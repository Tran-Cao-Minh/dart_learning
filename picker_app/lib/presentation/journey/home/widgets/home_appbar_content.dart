import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/theme/theme.dart';

extension HomeAppBarContentTheme on ThemeData {
  TextStyle get homeAppBarUserName => primaryBodyMediumBold.copyWith(
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get homeAppBarDateTime => primaryBodySmall.copyWith(
        fontSize: dimen_14.sp,
        height: dimen_20.sp.toLineHeight(dimen_14.sp),
      );

  TextStyle get homeAppBarStatus => primaryBodySmall.copyWith(
        color: green2196,
        fontSize: dimen_14.sp,
        height: dimen_16.sp.toLineHeight(dimen_14.sp),
      );
}

class HomeAppBarContent extends StatelessWidget {
  const HomeAppBarContent({Key? key}) : super(key: key);

  void _onDrawerTapped() {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: dimen_8.w,
        ),
        InkButton(
          onTap: _onDrawerTapped,
          width: dimen_40.w,
          height: dimen_40.w,
          child: Center(
            child: AppIcon(
              AppIcons.hamburger,
              width: dimen_24.w,
              height: dimen_24.w,
            ),
          ),
        ),
        SizedBox(
          width: dimen_8.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nguyễn Văn A',
                style: Theme.of(context).homeAppBarUserName,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: dimen_4.h,
                ),
                child: Text(
                  'T7, 20/02/2022',
                  style: Theme.of(context).homeAppBarDateTime,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: dimen_8.w,
        ),
        InkButton(
          onTap: _onDrawerTapped,
          padding: EdgeInsets.symmetric(
            vertical: dimen_4.h,
            horizontal: dimen_12.w,
          ),
          borderRadius: dimen_16,
          bgColor: greenE9F5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Active',
                style: Theme.of(context).homeAppBarStatus,
              ),
              SizedBox(
                width: dimen_8.w,
              ),
              AppIcon(
                AppIcons.pickerStatus,
                color: green2196,
                width: dimen_24.w,
                height: dimen_24.h,
              ),
            ],
          ),
        ),
        SizedBox(
          width: dimen_16.w,
        ),
      ],
    );
  }
}
