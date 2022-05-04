import 'package:flutter/material.dart';
import 'package:picker/data/models/dummy_picker_info_model.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/common/widgets/animated_count.dart';

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

class OrderTable extends StatefulWidget {
  OrderTable({Key? key}) : super(key: key);

  @override
  _OrderTableState createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(
          () {}); // Used to start count number. Change this to set data form api.
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: normalize(14),
                  height: 20 / 14,
                  fontWeight: FontWeight.normal,
                  color: black66,
                ),
              ),
              AnimatedCount(
                count: dummyPickerInfoModel.completedOrderCount,
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: normalize(18),
                  height: 24 / 18,
                  fontWeight: FontWeight.bold,
                  color: green53,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          height: normalize(28),
          color: purpleDC,
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trôi đơn',
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: normalize(14),
                  height: 20 / 14,
                  fontWeight: FontWeight.normal,
                  color: black66,
                ),
              ),
              AnimatedCount(
                count: dummyPickerInfoModel.missedOrderCount,
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: normalize(18),
                  height: 24 / 18,
                  fontWeight: FontWeight.bold,
                  color: orange00,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          height: normalize(28),
          color: purpleDC,
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hủy đơn',
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: normalize(14),
                  height: 20 / 14,
                  fontWeight: FontWeight.normal,
                  color: black66,
                ),
              ),
              AnimatedCount(
                count: dummyPickerInfoModel.canceledOrderCount,
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: normalize(18),
                  height: 24 / 18,
                  fontWeight: FontWeight.bold,
                  color: red0D,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
