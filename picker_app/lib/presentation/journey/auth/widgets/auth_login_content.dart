import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/presentation/theme/theme.dart';

extension AuthLoginContentTheme on ThemeData {
  TextStyle get authLoginContentTitle => primaryHeadlineMedium.copyWith(
    fontSize: dimen_30.sp,
    height: dimen_38.sp.toLineHeight(dimen_30.sp),
    fontWeight: FontWeight.w500,
  );

  TextStyle get authLoginContentMessage => primaryBodyMedium.copyWith(
    fontSize: dimen_16.sp,
    height: dimen_18.sp.toLineHeight(dimen_16.sp),
  );
}

class AuthLoginContent extends StatelessWidget {
  AuthLoginContent({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: dimen_8.h,
        ),
        Text(
            title,
          style: Theme.of(context).authLoginContentTitle,
        ),
        SizedBox(
          height: dimen_8.h,
        ),
        Text(
          message,
          style: Theme.of(context).authLoginContentMessage,
        ),
        SizedBox(
          height: dimen_32.h,
        ),
      ],
    );
  }
}
