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
  timePerOrder: 32.5,
  timePerItem: 5.7,
  timeProductivityPercent: 90.5,
);

class ProductivityTable extends StatefulWidget {
  ProductivityTable({Key? key}) : super(key: key);

  @override
  _ProductivityTableState createState() => _ProductivityTableState();
}

class _ProductivityTableState extends State<ProductivityTable> {
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
                'TB theo đơn',
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
                count: dummyPickerInfoModel.timePerOrder,
                suffix: 's/đơn',
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: normalize(18),
                  height: 24 / 18,
                  fontWeight: FontWeight.bold,
                  color: fuschia,
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
                'TB theo item',
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
                count: dummyPickerInfoModel.timePerItem,
                suffix: 's/sp',
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: normalize(18),
                  height: 24 / 18,
                  fontWeight: FontWeight.bold,
                  color: fuschia,
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
                'Thời gian',
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
                count: dummyPickerInfoModel.timeProductivityPercent.round(),
                suffix: '%',
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: normalize(18),
                  height: 24 / 18,
                  fontWeight: FontWeight.bold,
                  color: fuschia,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
