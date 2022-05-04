import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/common_widget/red_dot_notify_view.dart';
import 'package:picker/common_widget/remaining_time_pick_view.dart';
import 'package:picker/screens/picking_summary/view/rounded_icon_label_view.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

class PlaceOrderCompletedScreen extends StatelessWidget {
  const PlaceOrderCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: greyF8,
      body: Column(
        children: [
          Expanded(
              child: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                floating: false,
                titleSpacing: 0,
                backgroundColor: white,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(normalize(54)),
                  child: RemainingTimePickView(
                    onCallCustomer: () {},
                  ),
                ),
                title: Text(
                  'Place order',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w700,
                    fontSize: normalize(16),
                    height: 19.0 / 16.0,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/ic_nav_back.svg',
                    fit: BoxFit.scaleDown,
                    height: normalize(30),
                    width: normalize(30),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: _WaitingNumberView(),
              ),
              const SliverToBoxAdapter(
                child: _PrinterView(),
              ),
            ],
          )),
          const _BottomButtonView()
        ],
      ),
    ));
  }
}

class _BottomButtonView extends StatelessWidget {
  const _BottomButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: normalize(35)),
      padding: EdgeInsets.all(normalize(16)),
      color: white,
      child: SizedBox(
        width: double.infinity,
        height: normalize(55),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                return fushiaC8A;
              },
            ),
          ),
          child: Text(
            'Hoàn thành đơn hàng',
            style: TextStyleCommon.displayHeader(context,
                fontSize: 15, height: 20 / 15, color: white),
          ),
        ),
      ),
    );
  }
}

class _WaitingNumberView extends StatelessWidget {
  const _WaitingNumberView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(normalize(16)),
      color: white,
      child: Column(
        children: [
          Image.asset(
            'assets/images/ic_order_completed.png',
            width: normalize(150),
            height: normalize(112),
          ),
          Text(
            'Bạn vui lòng đóng gói hàng và đặt vào đúng vị trí '
            'để chuẩn bị giao hàng',
            textAlign: TextAlign.center,
            style: TextStyleCommon.displaySubBody(context,
                fontSize: 16, height: 23.55 / 16),
          ),
          Text(
            '8A',
            textAlign: TextAlign.center,
            style: TextStyleCommon.displayHeaderBold(context,
                fontSize: 48, height: 65.85 / 48),
          )
        ],
      ),
    );
  }
}

class _PrinterView extends StatelessWidget {
  const _PrinterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: normalize(10)),
      padding: EdgeInsets.only(
          left: normalize(16),
          right: normalize(16),
          top: normalize(16),
          bottom: normalize(28)),
      color: white,
      child: Column(
        children: [
          Image.asset(
            'assets/images/ic_printer.png',
            width: normalize(150),
            height: normalize(112),
          ),
          Text(
            'In thông tin đơn hàng đính kèm giỏ hàng',
            textAlign: TextAlign.center,
            style: TextStyleCommon.displaySubBody(context,
                fontSize: 16, height: 23.55 / 16),
          ),
          SizedBox(
            height: normalize(8),
          ),
          const _PrinterNowButtonView(),
        ],
      ),
    );
  }
}

class _PrinterNowButtonView extends StatelessWidget {
  const _PrinterNowButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: normalize(135),
      height: normalize(45),
      child: Stack(children: [
        Positioned(
            top: 5,
            child: Material(
              color: blue0FF,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                normalize(100),
              )),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: normalize(130),
                  height: normalize(34),
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
                        Text(
                          'In ngay',
                          textAlign: TextAlign.center,
                          style: TextStyleCommon.displayHeader(context,
                              fontSize: 16, color: blue6DFF),
                        ),
                        SizedBox(
                          width: normalize(8),
                        ),
                        SvgPicture.asset(
                          'assets/icons/ic_printer.svg',
                          fit: BoxFit.scaleDown,
                          color: blue6DFF,
                          height: normalize(20),
                          width: normalize(20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
        Positioned(
          top: 0,
          right: 0,
          child: RedDotNotifyView(
            notifyCount: 5,
            padding: EdgeInsets.all(normalize(7)),
          ),
        )
      ]),
    );
  }
}
