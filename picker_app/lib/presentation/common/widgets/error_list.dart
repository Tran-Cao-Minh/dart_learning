import 'package:flutter/material.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'package:picker/common/common.dart';

extension ErrorListTheme on ThemeData {
  TextStyle get errorListReloadBtn => primaryButton.copyWith(
    color: Colors.white,
    fontSize: dimen_16.sp,
    height: dimen_19.sp.toLineHeight(dimen_16.sp),
  );
}

class ErrorList extends StatelessWidget {
  final VoidCallback doReload;
  final String errorMessage;
  final String errorTitle;
  final bool shouldShowReload;

  ErrorList({
    Key? key,
    required this.errorMessage,
    required this.errorTitle,
    required this.doReload,
    required this.shouldShowReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.queryWidth,
      height: context.queryHeight / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: dimen_20.h,
          ),
          Text(
            errorTitle,
          ),
          SizedBox(
            height: dimen_12.h,
          ),
          Text(
            errorMessage,
          ),
          SizedBox(
            height: dimen_12.h,
          ),
          if (shouldShowReload)
            InkButton(
              onTap: doReload.call,
              borderRadius: dimen_5,
              bgColor: purple8B6E,
              width: dimen_120.w,
              height: dimen_40.h,
              child: Center(
                child: Text(
                  'Reload',
                  style: Theme.of(context).errorListReloadBtn,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
