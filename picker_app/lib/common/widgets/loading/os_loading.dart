import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';

class OSLoading extends StatelessWidget {
  const OSLoading({
    Key? key,
  }) : super(key: key);

  bool get isAppleOS => Platform.isIOS || Platform.isMacOS;

  double get _getSize {
    if (isAppleOS) {
      return dimen_48.w;
    }

    return dimen_24.w;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: dimen_72.w,
        height: dimen_72.w,
        padding: EdgeInsets.symmetric(
          horizontal: dimen_4.w,
        ),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(dimen_6.w),
        ),
        child: Center(
          child: SizedBox.fromSize(
            size: Size.square(_getSize),
            child: isAppleOS
                ? CupertinoTheme(
                    data: const CupertinoThemeData(
                      brightness: Brightness.dark,
                    ),
                    child: CupertinoActivityIndicator(
                      radius: dimen_16.w,
                    ),
                  )
                : CircularProgressIndicator(
                    strokeWidth: dimen_4.w,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
