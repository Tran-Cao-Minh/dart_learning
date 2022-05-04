import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/theme/theme.dart';

extension HomeSectionTheme on ThemeData {
  TextStyle get homerSectionTitle => primaryTitleMedium.copyWith(
    fontSize: dimen_18.sp,
    height: dimen_24.sp.toLineHeight(dimen_18.sp),
  );
}

class HomeSection extends StatelessWidget {
  HomeSection({
    Key? key,
    required this.child,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final AppIcons icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(dimen_12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 3),
            spreadRadius: 0.0,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: dimen_12.h,
              horizontal: dimen_12.w,
            ),
            child: Row(
              children: [
                AppIcon(
                  icon,
                  width: dimen_24.w,
                  height: dimen_24.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: dimen_8.w,
                  ),
                  child: Text(
                    title,
                    style: Theme.of(context).homerSectionTitle,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: dimen_1.h,
            color: blackF1F1,
          ),
          child,
        ],
      ),
    );
  }
}
