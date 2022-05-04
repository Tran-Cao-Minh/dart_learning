import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/presentation/theme/theme.dart';

extension LoginSubmitButtonTheme on ThemeData {
  TextStyle get loginSubmitBtn => primaryButton.copyWith(
        color: Colors.white,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );
}

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    Key? key,
    required this.onPressed,
    required this.isEnabled,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isEnabled;

  Color get _bgColor {
    return isEnabled ? purple5930 : blackCCCC;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: KeyboardAvoid(
        autoScroll: true,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkButton(
                bgColor: _bgColor,
                height: dimen_48.h,
                onTap: isEnabled ? onPressed.call : () {},
                child: Text(
                  'Tiếp tục',
                  style: Theme.of(context).loginSubmitBtn,
                ),
              ),
              SizedBox(
                height: dimen_20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
