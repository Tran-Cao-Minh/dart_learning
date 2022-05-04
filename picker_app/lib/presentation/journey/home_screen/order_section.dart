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
  ChartData('Completed', dummyPickerInfoModel.completedOrderCount, green53),
  ChartData('Missed', dummyPickerInfoModel.missedOrderCount, orange00),
  ChartData('Canceled', dummyPickerInfoModel.canceledOrderCount, red0D),
];

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final int y;
  final Color color;
}

class OrderSection extends StatefulWidget {
  OrderSection({Key? key}) : super(key: key);

  @override
  _OrderSectionState createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
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
    return Column(
      children: [
        Container(
          height: normalize(128),
          margin: EdgeInsets.symmetric(vertical: normalize(24)),
          child: SfCircularChart(
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                widget: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: black33,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: dummyPickerInfoModel.totalOrder.toString(),
                        style: TextStyle(
                          fontSize: normalize(24),
                          height: 32 / 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' đơn',
                        style: TextStyle(
                          fontSize: normalize(14),
                          height: 20 / 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
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
                radius: '115%',
                innerRadius: '77%',
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: normalize(12),
            left: normalize(12),
            right: normalize(12),
          ),
          height: normalize(48),
          child: OrderTable(),
        ),
      ],
    );
  }
}
