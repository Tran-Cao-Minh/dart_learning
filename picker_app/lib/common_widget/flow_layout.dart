import 'package:flutter/material.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

class FlowLayout<T> extends StatelessWidget {
  final String? title;
  final List<T> data;
  final String Function(T) returnLabel;
  final bool Function(T) isSelected;
  final Function(T)? onTap;

  const FlowLayout({
    Key? key,
    this.title,
    required this.data,
    required this.returnLabel,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: title != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title ?? '',
                    style: TextStyleCommon.displayHeader(context)),
                SizedBox(
                  height: normalize(12),
                )
              ],
            )),
        Wrap(
          spacing: normalize(8),
          runSpacing: normalize(8),
          children: <Widget>[
            ...data.map<_ChipView>((item) => _ChipView(
                  text: returnLabel.call(item),
                  isSelected: isSelected.call(item),
                  onTap: () => onTap?.call(item),
                ))
          ],
        ),
      ],
    );
  }
}

class _ChipView extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChipView({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: normalize(12), vertical: normalize(10)),
        label: Text(
          text,
          style: TextStyleCommon.displaySubBody(context,
              fontSize: 17, color: isSelected ? white : black3F),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: isSelected ? blueFF : greyF3,
      ),
      onTap: onTap,
    );
  }
}
