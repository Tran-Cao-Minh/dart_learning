import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/common/widgets/my_input_field.dart';
import 'package:picker/common_widget/flow_layout.dart';
import 'package:picker/screens/picking_summary/bottomsheet/confirm_cancel_order_provider.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';
import 'package:provider/provider.dart';

class ConfirmCancelOrderBottomSheet extends StatelessWidget {
  const ConfirmCancelOrderBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmCancelOrderProvider>(
      create: (c) => ConfirmCancelOrderProvider(),
      builder: (c, child) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ReasonListView(),
                  ],
                ),
              ),
              const _Bottom()
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: normalize(12),
        right: normalize(12),
      ),
      height: normalize(50),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                splashRadius: normalize(25),
                onPressed: () => Navigator.of(context).pop(),
                icon: SvgPicture.asset(
                  'assets/icons/ic_close.svg',
                  height: normalize(23),
                  width: normalize(23),
                  color: black32,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('Lý do hủy đơn của bạn là?',
                style: TextStyleCommon.displayHeader(context,
                    color: black3F, fontSize: 17)),
          )
        ],
      ),
    );
  }
}

class _ReasonListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: normalize(16)),
      child: Consumer<ConfirmCancelOrderProvider>(
        builder: (context, provder, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FlowLayout<String>(
                data: provder.reasonList,
                returnLabel: (reason) => reason,
                isSelected: (reason) => reason == provder.valueSelected,
                onTap: (reason) {
                  provder.setReasonSelected(reason);
                },
              ),
              SizedBox(
                height: normalize(16),
              ),
              provder.isShowOtherReasonInput() == true
                  ? MyInputField(
                      minLines: 5,
                      maxLines: 5,
                      hint: 'Lý do gì đó',
                      hintStyle: TextStyleCommon.displaySubBody(context,
                          color: grey3F.withOpacity(0.2), fontSize: 17),
                      // style:
                      //     TextStyleCommon.displaySubBody(context, fontSize: 17),
                      onChanged: (value) => provder.updateOtherReason(value),
                    )
                  : const SizedBox.shrink()
            ],
          );
        },
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ConfirmCancelOrderProvider>();
    return Padding(
      padding: EdgeInsets.all(normalize(16)),
      child: SizedBox(
        width: double.infinity,
        height: normalize(55),
        child: ElevatedButton(
          onPressed: provider.isEnableCancelButton() ? () {} : null,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                return provider.isEnableCancelButton() ? fushiaC8A : grey3A;
              },
            ),
          ),
          child: Text(
            'Gửi & hủy đơn',
            style: TextStyleCommon.displayHeader(context,
                fontSize: 15, height: 20 / 15, color: white),
          ),
        ),
      ),
    );
  }
}
