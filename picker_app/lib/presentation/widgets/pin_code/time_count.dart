import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/presentation/theme/theme.dart';

extension PinCodeTimerTheme on ThemeData {
  TextStyle get pinCodeTimerResendBtn => primaryButtonBold.copyWith(
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get pinCodeTimerVal => primaryBodyMedium.copyWith(
        color: redE70D,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );
}

class PinCodeTimeCount extends StatelessWidget {
  final String? timeString;
  final double? progressVal;
  final bool shouldEnableResend;
  final VoidCallback? onResendTapped;

  PinCodeTimeCount({
    Key? key,
    this.progressVal,
    this.timeString,
    required this.shouldEnableResend,
    required this.onResendTapped,
  }) : super(key: key);

  String get _timeCount {
    if (timeString.isNotNullAndEmpty) {
      return timeString!;
    }

    return 'N/A';
  }

  Color get _resendBtnColor {
    return shouldEnableResend ? blue1976 : black9999;
  }

  void _onResendTapped() {
    onResendTapped?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dimen_16.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkButton(
            onTap: _onResendTapped,
            height: dimen_32.h,
            child: Text(
              'Gửi lại OTP',
              style: Theme.of(context).pinCodeTimerResendBtn.copyWith(
                    color: _resendBtnColor,
                  ),
            ),
          ),
          SizedBox(
            width: dimen_10.w,
          ),
          Text(
            _timeCount,
            style: Theme.of(context).pinCodeTimerVal,
          ),
        ],
      ),
    );
  }
}
