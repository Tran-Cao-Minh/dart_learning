import 'package:flutter/material.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'package:picker/common/common.dart';

extension EmptyListTheme on ThemeData {
  TextStyle get emptyListTitle => primaryTitleMedium.copyWith(
        fontSize: dimen_16.sp,
        height: dimen_19.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get emptyListMessage => primaryBodyMedium.copyWith(
        fontSize: dimen_16.sp,
        height: dimen_19.sp.toLineHeight(dimen_16.sp),
      );
}

class EmptyList extends StatelessWidget {
  final String message;
  final String title;
  final bool isBlank;

  EmptyList({
    Key? key,
    required this.message,
    required this.title,
    this.isBlank = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isBlank) {
      return const SizedBox.shrink();
    }

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
            title,
            style: Theme.of(context).emptyListTitle,
          ),
          SizedBox(
            height: dimen_12.h,
          ),
          Text(
            message,
            style: Theme.of(context).emptyListMessage,
          ),
          SizedBox(
            height: dimen_12.h,
          ),
        ],
      ),
    );
  }
}
