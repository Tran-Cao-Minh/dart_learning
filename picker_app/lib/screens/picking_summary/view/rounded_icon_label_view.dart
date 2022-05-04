import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

class RoundedIconLabelView extends StatelessWidget {
  final String assetsName;
  final String label;
  final VoidCallback? onPressed;

  const RoundedIconLabelView({
    Key? key,
    required this.assetsName,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        normalize(100),
      )),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: normalize(37),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
            normalize(100),
          )),
          padding: EdgeInsets.symmetric(
              horizontal: normalize(20), vertical: normalize(6)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/$assetsName.svg',
                  fit: BoxFit.scaleDown,
                  height: normalize(20),
                  width: normalize(20),
                ),
                SizedBox(
                  width: normalize(8),
                ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style:
                      TextStyleCommon.displayHeaderBold(context, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
