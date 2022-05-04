import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/presentation/theme/theme.dart';

extension HomeOrderTableTheme on ThemeData {
  TextStyle get homeOrderTableTitle => primaryBodySmall.copyWith(
        color: black6666,
        fontSize: dimen_14.sp,
        height: dimen_20.sp.toLineHeight(dimen_14.sp),
      );

  TextStyle get homeOrderTableCount => primaryTitleMedium.copyWith(
        fontSize: dimen_18.sp,
        height: dimen_24.sp.toLineHeight(dimen_18.sp),
      );
}

class HomeOrderTable extends StatelessWidget {
  HomeOrderTable({
    Key? key,
    required this.completedCount,
    required this.missedCount,
    required this.cancelledCount,
  }) : super(key: key);

  final int completedCount;
  final int missedCount;
  final int cancelledCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hoàn thành',
                maxLines: 1,
                style: Theme.of(context).homeOrderTableTitle,
              ),
              SizedBox(
                height: dimen_4.h,
              ),
              AnimatedCount(
                count: completedCount,
                textStyle: Theme.of(context)
                    .homeOrderTableCount
                    .copyWith(color: green2196),
              ),
            ],
          ),
        ),
        Container(
          width: dimen_1.w,
          height: dimen_28.h,
          color: purpleCDC1,
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trôi đơn',
                maxLines: 1,
                style: Theme.of(context).homeOrderTableTitle,
              ),
              SizedBox(
                height: dimen_4.h,
              ),
              AnimatedCount(
                count: missedCount,
                textStyle: Theme.of(context)
                    .homeOrderTableCount
                    .copyWith(color: orangeFF7B),
              ),
            ],
          ),
        ),
        Container(
          width: dimen_1.w,
          height: dimen_28.h,
          color: purpleCDC1,
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hủy đơn',
                maxLines: 1,
                style: Theme.of(context).homeOrderTableTitle,
              ),
              SizedBox(
                height: dimen_4.h,
              ),
              AnimatedCount(
                count: cancelledCount,
                textStyle: Theme.of(context)
                    .homeOrderTableCount
                    .copyWith(color: redE70D),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
