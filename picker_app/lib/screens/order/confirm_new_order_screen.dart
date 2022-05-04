import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/screens/order/confirm_new_order_provider.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';
import 'package:provider/provider.dart';

class ConfirmNewOrderScreen extends StatefulWidget {
  const ConfirmNewOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmNewOrderScreen> createState() => _ConfirmNewOrderScreenState();
}

class _ConfirmNewOrderScreenState extends State<ConfirmNewOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setStatusBarWhite() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: white,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _setStatusBarWhite();
        return true;
      },
      child: Container(
        color: pinkFF,
        child: SafeArea(
            child: ChangeNotifierProvider<ConfirmNewOrderProvider>(
          create: (c) => ConfirmNewOrderProvider(),
          builder: (c, child) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: pinkFF,
                centerTitle: true,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: pinkFF,
                    statusBarBrightness: Brightness.light),
                title: Text(
                  'Đơn hàng mới',
                  style: TextStyleCommon.displayHeader(context, fontSize: 17),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _setStatusBarWhite();
                    },
                    icon: SvgPicture.asset('assets/icons/ic_close.svg')),
              ),
              backgroundColor: white,
              body: _ConfirmNewOrderBody(),
            );
          },
        )),
      ),
    );
  }
}

class _ConfirmNewOrderBody extends StatefulWidget {
  const _ConfirmNewOrderBody({Key? key}) : super(key: key);

  @override
  State<_ConfirmNewOrderBody> createState() => _ConfirmNewOrderBodyState();
}

class _ConfirmNewOrderBodyState extends State<_ConfirmNewOrderBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: pinkFF,
          width: double.infinity,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _HeaderView(),
              ),
              SliverFillRemaining(
                child: _ContentView(),
              )
            ],
          ),
        ),
        Positioned(
            left: normalize(generalHorizontalPadding),
            right: normalize(generalHorizontalPadding),
            bottom: normalize(16),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(normalize(10))),
              height: normalize(55),
              color: fushiaC8A,
              onPressed: () {},
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Nhận đơn ngay',
                      textAlign: TextAlign.center,
                      style: TextStyleCommon.displayHeader(context,
                          color: white, fontSize: 16),
                    ),
                  ),
                  Align(
                    child: Container(
                      padding: EdgeInsets.all(normalize(7)),
                      decoration: BoxDecoration(
                          color: fushia71, shape: BoxShape.circle),
                      child: Text(
                        '15',
                        style: TextStyleCommon.displayHeader(context,
                            fontSize: 16, color: white),
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: normalize(26),
        ),
        Text(
          'Số lượng sản phẩm',
          style: TextStyleCommon.displaySubBody(
            context,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: normalize(16),
        ),
        Text(
          '09',
          style: TextStyleCommon.displayHeaderBold(context, fontSize: 96),
        ),
        SizedBox(
          height: normalize(16),
        ),
        Text(
          'Giá trị đơn',
          style: TextStyleCommon.displaySubBody(
            context,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: normalize(12),
        ),
        Text(
          '395.000đ',
          style: TextStyleCommon.displayHeader(
            context,
            fontSize: 24,
          ),
        ),
        SizedBox(
          height: normalize(12),
        ),
      ],
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          top: normalize(27), left: normalize(37), right: normalize(37)),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(normalize(17)),
              topRight: Radius.circular(normalize(17)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ItemPropertyView(title: 'Thời gian', value: '20:00'),
          _ItemPropertyView(title: 'Mã đơn hàng', value: '9238492'),
          _ItemPropertyView(title: 'Số điện thoại KH', value: '0987 *** 321'),
          _ItemPropertyView(
              title: 'Nhận hàng cách bạn 2.5km',
              value:
                  'Charmvit Tower - tổ hợp Grand Plaza số 117 Trần Duy Hưng, quận Cầu Giấy, Hà Nội'),
        ],
      ),
    );
  }
}

class _ItemPropertyView extends StatelessWidget {
  final String title;
  final String value;
  const _ItemPropertyView({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: normalize(26)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyleCommon.displaySubBody(context, fontSize: 16),
          ),
          SizedBox(
            height: normalize(8),
          ),
          Text(
            value,
            style: TextStyleCommon.displayHeaderBold(context, fontSize: 24),
          )
        ],
      ),
    );
  }
}
