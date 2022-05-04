import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

import '../model/order_history_model.dart';

class ItemOrderHistoryView extends StatelessWidget {
  final OrderHistoryModel item;

  const ItemOrderHistoryView({
    Key? key,
    required this.item,
  }) : super(key: key);

  Widget _renderTitle(BuildContext context) {
    switch (item.type) {
      case EOrderHistoryType.completed:
      case EOrderHistoryType.cancelled:
        return RichText(
          text: TextSpan(
              text: item.type.status,
              style: TextStyleCommon.displaySubBody(context,
                  fontSize: 16, color: black, height: 20.03 / 16),
              children: [
                TextSpan(
                    text: ' ${item.orderId}',
                    style: TextStyleCommon.displayHeaderBold(context,
                        fontSize: 16, color: black, height: 20.03 / 16))
              ]),
        );
      case EOrderHistoryType.missed:
        return Text(
          'Bị bỏ lỡ đơn hàng',
          style: TextStyleCommon.displaySubBody(context,
              fontSize: 16, color: black, height: 20.03 / 16),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _renderDescription(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'Mã pick ',
          style: TextStyleCommon.displaySubBody(context,
              fontSize: 14, color: grey66, height: 16.41 / 14),
          children: [
            TextSpan(
                text: '${item.pickId} ',
                style: TextStyleCommon.displaySubBody(context,
                    fontSize: 14, color: grey66, height: 16.41 / 14)),
            TextSpan(
                text: '• ${item.pickedDate}',
                style: TextStyleCommon.displaySubBody(context,
                    fontSize: 14, color: grey66, height: 16.41 / 14)),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          // final DateTimeRange picked = await showDateRangePicker(
          //   context: context,
          //   firstDate: DateTime.now(),
          //   helpText: 'Select a Date or Date-Range',
          //   fieldStartHintText: 'Start Booking date',
          //   fieldEndHintText: 'End Booking date',
          //   currentDate: DateTime.now(),
          //   lastDate: DateTime(2023),
          //   builder: (BuildContext context, Widget child) {
          //     return Theme(
          //       data: ThemeData.dark().copyWith(
          //         colorScheme: ColorScheme.dark(
          //           primary: Colors.greenAccent,
          //           surface: Colors.greenAccent,
          //         ),

          //         // Here I Chaged the overline to my Custom TextStyle.
          //         textTheme: TextTheme(overline: TextStyle(fontSize: 16)),
          //       ),
          //       child: child,
          //     );
          //   },
          // );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: normalize(generalHorizontalPadding),
              vertical: normalize(12)),
          child: Row(
            children: [
              SvgPicture.asset(
                item.type.resourceName,
                height: normalize(24),
                width: normalize(24),
                color: item.getResourceColor(),
              ),
              SizedBox(
                width: normalize(11),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _renderTitle(context)),
                      Text(
                        '${item.totalCount} sp',
                        style: TextStyleCommon.displayHeaderBold(context,
                            fontSize: 16, color: black, height: 18.75 / 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _renderDescription(context)),
                      Text(
                        item.getTotalPickedTime(),
                        style: TextStyleCommon.displayHeaderBold(context,
                            fontSize: 14,
                            color: item.getPickedTimeColor(),
                            height: 18.75 / 16),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
