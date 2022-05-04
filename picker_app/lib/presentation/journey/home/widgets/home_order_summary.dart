import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/journey/home/widgets/home_section.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'home_order_table.dart';

List<ChartData> chartData = [
  ChartData('Completed', 150, green2196),
  ChartData('Missed', 40, orangeFF7B),
  ChartData('Canceled', 23, redE70D),
];

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final int y;
  final Color color;
}

extension HomeOrderSummaryTheme on ThemeData {
  TextStyle get homeOrderSummaryTotalNumber => primaryBodySmall.copyWith(
        fontSize: dimen_14.sp,
        height: dimen_20.sp.toLineHeight(dimen_14.sp),
      );

  TextStyle get homeOrderSummaryTotalNumberBold => primaryNumber.copyWith(
        fontSize: dimen_24.sp,
        height: dimen_32.sp.toLineHeight(dimen_24.sp),
      );
}

class HomeOrderSummary extends StatelessWidget {
  const HomeOrderSummary({Key? key}) : super(key: key);

  String get _textQuery {
    return '203';
  }

  String get _message {
    return '203 đơn';
  }

  @override
  Widget build(BuildContext context) {
    return HomeSection(
      icon: AppIcons.orderSection,
      title: 'Đơn hàng',
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: dimen_24.h,
            ),
            height: dimen_128.h,
            child: SfCircularChart(
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: MyTextSpan(
                    text: _message.toMapQueryToTextTag(
                      textQuery: _textQuery,
                      startTag: Tag.startBold,
                      endTag: Tag.endBold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    defaultStyle: Theme.of(context).homeOrderSummaryTotalNumber,
                    boldStyle:
                        Theme.of(context).homeOrderSummaryTotalNumberBold,
                  ),
                ),
              ],
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  pointColorMapper: (ChartData data, _) => data.color,
                  animationDuration: 1000,
                  radius: '115%',
                  innerRadius: '77%',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: dimen_12.w,
              right: dimen_12.w,
              bottom: dimen_12.h,
            ),
            child: HomeOrderTable(
              completedCount: 1920,
              missedCount: 40,
              cancelledCount: 23,
            ),
          ),
        ],
      ),
    );
  }
}
