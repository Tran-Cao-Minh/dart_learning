import 'package:flutter/material.dart';
import 'package:picker/screens/picking_summary/view/rounded_icon_label_view.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';

class RemainingTimePickView extends StatelessWidget {
  final VoidCallback onCallCustomer;

  const RemainingTimePickView({Key? key, required this.onCallCustomer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyF8,
      padding: EdgeInsets.symmetric(
          horizontal: normalize(8), vertical: normalize(6)),
      child: Row(
        children: [
          const RoundedIconLabelView(
            assetsName: 'ic_clock',
            label: '20:02',
          ),
          SizedBox(
            width: normalize(8),
          ),
          Expanded(
            child: RoundedIconLabelView(
              assetsName: 'ic_phone',
              label: 'Gọi điện cho KH',
              onPressed: onCallCustomer,
            ),
          ),
        ],
      ),
    );
  }
}
