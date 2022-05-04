import 'package:flutter/material.dart';
import 'package:picker/screens/order_history/order_history_mock_data.dart';
import 'package:picker/screens/order_history/widget/item_order_history_view.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

class OrderHistorySectionView extends StatelessWidget {
  const OrderHistorySectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = orderHistoryMockData.take(5).toList();
    return Container(
      color: white,
      margin: EdgeInsets.only(
        top: normalize(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: normalize(22),
                bottom: normalize(8),
                left: normalize(generalHorizontalPadding),
                right: normalize(generalHorizontalPadding)),
            child: Text(
              'Lịch sử pick hàng',
              style: TextStyleCommon.displayHeaderBold(context, fontSize: 20),
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, pos) =>
                  ItemOrderHistoryView(item: items[pos]))
        ],
      ),
    );
  }
}
