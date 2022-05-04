import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/route/route_constant.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';
import 'package:provider/provider.dart';

import 'provider/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        builder: (context, child) => const AuthScreenContent());
  }
}

class AuthScreenContent extends StatefulWidget {
  const AuthScreenContent({Key? key}) : super(key: key);

  @override
  State<AuthScreenContent> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreenContent> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final authProvider = context.read<AuthProvider>();
      _phoneController.addListener(() {
        authProvider.checkValidPhoneNumber(_phoneController.text.trim());
      });
    });

    /// Lấy thông tin config OTP: (Số lẩn retry, thời gian sử dụng của OTP, ...)
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              elevation: 0,
              backgroundColor: white,
            )),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: normalize(44),
                    height: normalize(44),
                    margin: EdgeInsets.only(
                      bottom: normalize(8),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (Navigator.canPop(context)) {
                              Navigator.of(context).pop();
                            } else {
                              // widget.bottomTapped(0);
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/icons/ic_nav_back.svg',
                            fit: BoxFit.scaleDown,
                            height: normalize(10),
                            width: normalize(18),
                          )),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: normalize(generalHorizontalPadding),
                            left: normalize(generalHorizontalPadding),
                            bottom: normalize(10),
                          ),
                          child: Text(
                            "Số điện thoại",
                            style: TextStyleCommon.displayHeader(context,
                                color: black, fontSize: 30, height: 38 / 30),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: normalize(generalHorizontalPadding),
                              left: normalize(generalHorizontalPadding),
                              bottom: 25),
                          child: Text(
                            "Nhập số điện thoại đã đăng ký với QLTT",
                            style: TextStyleCommon.displaySubBody(context,
                                color: black, fontSize: 16, height: 20 / 16),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: normalize(generalHorizontalPadding)),
                                width: normalize(60),
                                height: normalize(45),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: greyBE),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/vietnam_flag.png',
                                      height: normalize(24),
                                      width: normalize(24),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: _InputPhoneView(
                                  controller: _phoneController,
                                ),
                              )
                            ]),
                            const _MessageView()
                          ],
                        ),
                      ],
                    ),
                  ),
                  const _BottomView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputPhoneView extends StatelessWidget {
  final TextEditingController controller;
  const _InputPhoneView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final autheProvider = context.read<AuthProvider>();
    return Container(
      height: normalize(45),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: autheProvider.isPhoneInvalid ? red : lilac,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.only(
          left: normalize(10), right: normalize(generalHorizontalPadding)),
      child: Center(
        child: TextField(
          autofocus: true,
          // focusNode: myFocusNode,
          cursorColor: black,
          controller: controller,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          // onChanged: (value) {
          //   print(value);
          //   isValidPhoneNumber(value);
          // },
          decoration: InputDecoration(
            hintText: "Nhập số điện thoại",
            hintStyle: TextStyleCommon.displaySubBody(context,
                color: grey49, fontSize: 16),
            contentPadding: EdgeInsets.only(left: normalize(8)),
            suffixIcon: _ClearButtonView(
              controller: controller,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w600,
            fontSize: normalize(18),
            height: 25.0 / 18.0,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}

class _ClearButtonView extends StatelessWidget {
  final TextEditingController controller;

  const _ClearButtonView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final autheProvider = context.watch<AuthProvider>();
    if (controller.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return IconButton(
      onPressed: () {
        controller.clear();
      },
      icon: SvgPicture.asset(
        autheProvider.isPhoneInvalid
            ? 'assets/icons/warning.svg'
            : 'assets/icons/ic_circle_clear_text.svg',
        color: autheProvider.isPhoneInvalid ? red : blackAlpha40,
        height: normalize(20),
        width: normalize(20),
      ),
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (c, provider, child) {
      return provider.isPhoneInvalid
          ? Container(
              margin: EdgeInsets.only(
                  top: normalize(10),
                  left:
                      normalize(generalHorizontalPadding * 2) + normalize(56)),
              child: Text(
                "Số điện thoại không đúng.",
                style: TextStyle(
                  color: red,
                  fontSize: normalize(12),
                  fontWeight: FontWeight.normal,
                  height: 17 / 12,
                  fontStyle: FontStyle.normal,
                ),
              ),
            )
          : const SizedBox.shrink();
    });
  }
}

class _BottomView extends StatelessWidget {
  const _BottomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (c, provider, child) {
      return Container(
        width: double.infinity,
        height: 50.0,
        margin: EdgeInsets.only(
          right: normalize(24),
          left: normalize(24),
          top: normalize(20),
          bottom: normalize(20),
        ),
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RouteConstant.authPassword);
          },
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                width: 1.0,
                color: provider.isPhoneInvalid ? grey3A : fushiaC8A,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (provider.isPhoneInvalid) return grey3A;
                return fushiaC8A;
              },
            ),
          ),
          child: Text(
            "Tiếp tục",
            style: TextStyle(
              color: Colors.white,
              fontSize: normalize(15),
              fontStyle: FontStyle.normal,
              height: 20 / 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}
