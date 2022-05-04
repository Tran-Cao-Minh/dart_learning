import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

class OrderHistoryEmptyView extends StatelessWidget {
  const OrderHistoryEmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      padding: EdgeInsets.all(normalize(16)),
      child: Column(
        children: [
          SizedBox(
            height: normalize(80),
          ),
          SvgPicture.asset(
            'assets/icons/bg_order_history_empty.svg',
            width: normalize(202),
            height: normalize(150),
          ),
          SizedBox(
            height: normalize(6),
          ),
          Text(
            'Lịch sử đang trống',
            style: TextStyleCommon.displayHeader(context,
                fontSize: 20, height: 23.87 / 20),
          ),
          SizedBox(
            height: normalize(10),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: normalize(34)),
            child: Text(
              'Tạm thời chưa có đơn hàng nào trong khoảng thời gian này,'
              'bạn có thể chọn khoảng thời gian khác để xem thêm.',
              textAlign: TextAlign.center,
              style: TextStyleCommon.displaySubBody(context,
                  color: grey3F, fontSize: 13, height: 15.51 / 13),
            ),
          )
        ],
      ),
    );
  }
}
