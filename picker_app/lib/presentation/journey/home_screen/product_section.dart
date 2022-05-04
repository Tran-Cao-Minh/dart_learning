import 'package:flutter/material.dart';
import 'package:picker/data/models/dummy_picker_info_model.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'order_table.dart';

DummyPickerInfoModel dummyPickerInfoModel = DummyPickerInfoModel(
  name: 'Nguyễn Văn A',
  isActive: false,
  totalOrder: 203,
  completedOrderCount: 150,
  missedOrderCount: 40,
  canceledOrderCount: 23,
  orderProductivityPercent: 70.5,
  timePerOrder: 32,
  timePerItem: 5,
  timeProductivityPercent: 90.5,
);

List<ChartData> chartData = [
  ChartData(
      'Percentage', dummyPickerInfoModel.orderProductivityPercent, fuschia),
  ChartData('Transparent',
      100.0 - dummyPickerInfoModel.orderProductivityPercent, purpleF3),
];

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class ProductSection extends StatefulWidget {
  ProductSection({Key? key}) : super(key: key);

  @override
  _ProductSectionState createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: normalize(16),
        bottom: normalize(12),
        left: normalize(12),
        right: normalize(12),
      ),
      height: normalize(68),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: normalize(48),
              child: OrderTable(),
            ),
          ),
          Stack(
            children: [
              SizedBox(
                height: normalize(68),
                width: normalize(68),
                child: SfCircularChart(
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: [
                        ChartData(
                          'Background',
                          100.0,
                          purpleF3,
                        ),
                      ],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, _) => data.color,
                      animationDuration: 1000,
                      radius: '130%',
                      innerRadius: '77%',
                      cornerStyle: CornerStyle.bothFlat,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: normalize(68),
                width: normalize(68),
                child: SfCircularChart(
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      widget: Text(
                        '${dummyPickerInfoModel.orderProductivityPercent.round().toString()}%',
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: normalize(20),
                          height: 28 / 20,
                          fontWeight: FontWeight.bold,
                          color: fuschia,
                        ),
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
                      radius: '130%',
                      innerRadius: '77%',
                      cornerStyle: CornerStyle.bothCurve,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
