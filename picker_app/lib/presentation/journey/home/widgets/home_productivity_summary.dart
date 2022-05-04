import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/theme/theme.dart';

import 'home_section.dart';

extension HomeProductivitySummaryTheme on ThemeData {
  TextStyle get homeProductivitySummaryTitle => primaryBodySmall.copyWith(
        color: black6666,
        fontSize: dimen_14.sp,
        height: dimen_20.sp.toLineHeight(dimen_14.sp),
      );

  TextStyle get homeProductivitySummaryCount => primaryTitleMedium.copyWith(
        color: purple5930,
        fontSize: dimen_18.sp,
        height: dimen_24.sp.toLineHeight(dimen_18.sp),
      );
}

class HomeProductivitySummary extends StatelessWidget {
  const HomeProductivitySummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeSection(
      icon: AppIcons.productivitySection,
      title: 'Hiệu suất',
      child: Padding(
        padding: EdgeInsets.only(
          top: dimen_16.h,
          bottom: dimen_12.h,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TB theo đơn',
                    maxLines: 1,
                    style: Theme.of(context).homeProductivitySummaryTitle,
                  ),
                  SizedBox(
                    height: dimen_4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedCount(
                        count: 32,
                        textStyle:
                            Theme.of(context).homeProductivitySummaryCount,
                      ),
                      Text(
                        's/sp',
                        style: Theme.of(context).homeProductivitySummaryCount,
                      ),
                    ],
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
                    'TB theo item',
                    maxLines: 1,
                    style: Theme.of(context).homeProductivitySummaryTitle,
                  ),
                  SizedBox(
                    height: dimen_4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedCount(
                        count: 34032,
                        textStyle:
                            Theme.of(context).homeProductivitySummaryCount,
                      ),
                      Text(
                        's/sp',
                        style: Theme.of(context).homeProductivitySummaryCount,
                      ),
                    ],
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
                    'Thời gian',
                    maxLines: 1,
                    style: Theme.of(context).homeProductivitySummaryTitle,
                  ),
                  SizedBox(
                    height: dimen_4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedCount(
                        count: 90,
                        textStyle:
                            Theme.of(context).homeProductivitySummaryCount,
                      ),
                      Text(
                        's/sp',
                        style: Theme.of(context).homeProductivitySummaryCount,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
