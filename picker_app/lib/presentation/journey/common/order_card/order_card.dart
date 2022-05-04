import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/theme/theme.dart';

extension OrderCardTheme on ThemeData {
  TextStyle get orderCardStatus => primaryBodyMedium.copyWith(
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get orderCardStatusBold => primaryBodyMediumBold.copyWith(
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get orderCardTotal => primaryBodyMediumBold.copyWith(
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get orderCardDate => primaryBodySmall.copyWith(
        color: black6666,
        fontSize: dimen_14.sp,
        height: dimen_20.sp.toLineHeight(dimen_14.sp),
      );

  TextStyle get orderCardShippingCompleted => primaryBodySmall.copyWith(
        color: orangeFF7B,
        fontSize: dimen_14.sp,
        height: dimen_20.sp.toLineHeight(dimen_14.sp),
      );
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
  }) : super(key: key);

  String get _textQuery {
    return '#03294234';
  }

  String get _message {
    return 'Hoàn thành #03294234';
  }

  @override
  Widget build(BuildContext context) {
    return InkButton(
      onTap: () {},
      padding: EdgeInsets.symmetric(
        horizontal: dimen_13.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: dimen_2.h,
            ),
            child: AppIcon(
              AppIcons.orderCompleted,
              width: dimen_24.w,
              height: dimen_24.h,
            ),
          ),
          SizedBox(
            width: dimen_8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextSpan(
                  text: _message.toMapQueryToTextTag(
                    textQuery: _textQuery,
                    startTag: Tag.startBold,
                    endTag: Tag.endBold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  defaultStyle: Theme.of(context).orderCardStatus,
                  boldStyle: Theme.of(context).orderCardStatusBold,
                ),
                SizedBox(
                  height: dimen_2.h,
                ),
                Text(
                  '10/02/2022 - 12:03',
                  style: Theme.of(context).orderCardDate,
                ),
              ],
            ),
          ),
          SizedBox(
            width: dimen_8.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '10’12s',
                style: Theme.of(context).orderCardTotal,
              ),
              SizedBox(
                height: dimen_2.h,
              ),
              Text(
                '10’12s',
                style: Theme.of(context).orderCardShippingCompleted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
