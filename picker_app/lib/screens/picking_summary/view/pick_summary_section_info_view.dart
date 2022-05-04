import 'package:flutter/material.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

class PSSectionInfoView extends StatelessWidget {
  final String title;
  final Widget child;

  const PSSectionInfoView({Key? key, required this.title, required this.child,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      padding: EdgeInsets.symmetric(
          horizontal: normalize(20), vertical: normalize(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyleCommon.displayHeader(context),
          ),
          SizedBox(
            height: normalize(12),
          ),
          child
        ],
      ),
    );
  }
}

class PSInfoPropertyView extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const PSInfoPropertyView({
    Key? key,
    required this.label,
    required this.value,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: normalize(30)),
      child: Row(
        children: [
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyleCommon.displaySubBody(context, fontSize: 14),
          ),
          Expanded(
              flex: 1,
              child: Text(value,
                  textAlign: TextAlign.end,
                  style: valueStyle ??
                      TextStyleCommon.displaySubBody(context,
                          fontSize: 16, color: black.withOpacity(0.3))))
        ],
      ),
    );
  }
}
