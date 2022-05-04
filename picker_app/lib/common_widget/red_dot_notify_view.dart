import 'package:flutter/material.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

class RedDotNotifyView extends StatelessWidget {
  final int notifyCount;
  final EdgeInsets? padding;
  const RedDotNotifyView({Key? key, required this.notifyCount, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(normalize(4)),
      decoration: const BoxDecoration(shape: BoxShape.circle, color: red),
      child: Text(
        notifyCount.toString(),
        style:
            TextStyleCommon.displayHeader(context, color: white, fontSize: 12),
      ),
    );
  }
}
