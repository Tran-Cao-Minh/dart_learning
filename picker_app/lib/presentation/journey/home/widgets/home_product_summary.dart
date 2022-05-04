import 'package:flutter/material.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/journey/home/widgets/home_order_table.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'package:picker/common/common.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'home_order_summary.dart';
import 'home_section.dart';

extension HomeProductSummaryTheme on ThemeData {
  TextStyle get homeProductSummaryPercent => primaryBodySmall.copyWith(
        color: purple5930,
        fontSize: dimen_20.sp,
        height: dimen_28.sp.toLineHeight(dimen_20.sp),
      );
}

class HomeProductSummary extends StatelessWidget {
  const HomeProductSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeSection(
      icon: AppIcons.productSection,
      title: 'Sản phẩm',
      child: Container(
        margin: EdgeInsets.only(
          top: dimen_16.h,
          bottom: dimen_12.h,
        ),
        child: Row(
          children: [
            SizedBox(
              width: dimen_12.w,
            ),
            Expanded(
              child: HomeOrderTable(
                completedCount: 1920,
                missedCount: 40,
                cancelledCount: 23,
              ),
            ),
            SizedBox(
              height: dimen_68.w,
              width: dimen_68.w,
              child: SfCircularChart(
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Text(
                      '70%',
                      maxLines: 1,
                      style: Theme.of(context).homeProductSummaryPercent,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: [
                      ChartData(
                        'Background',
                        70,
                        purple5930,
                      ),
                      ChartData(
                        'dfads',
                        20,
                        purpleEEEA,
                      ),
                    ],
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                    animationDuration: 1000,
                    radius: '130%',
                    innerRadius: '78%',
                    cornerStyle: CornerStyle.bothFlat,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: dimen_12.w,
            ),
          ],
        ),
      ),
    );
  }
}
