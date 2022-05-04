import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'provider/auth_otp_provider.dart';

class AuthOTPScreen extends StatelessWidget {
  const AuthOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthOTPProvider>(
      create: (context) => AuthOTPProvider(),
      builder: (_, __) => const AuthOTPScreenConsumer(),
    );
  }
}

class AuthOTPScreenConsumer extends StatefulWidget {
  const AuthOTPScreenConsumer({Key? key}) : super(key: key);

  @override
  State<AuthOTPScreenConsumer> createState() => _AuthOTPScreenConsumerState();
}

class _AuthOTPScreenConsumerState extends State<AuthOTPScreenConsumer> {
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
                    child: Container(
                      margin: EdgeInsets.only(
                        right: normalize(generalHorizontalPadding),
                        left: normalize(generalHorizontalPadding),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Xác thực OTP',
                            style: TextStyleCommon.displayHeader(context,
                                color: black, fontSize: 34, height: 39.84 / 34),
                          ),
                          SizedBox(
                            height: normalize(10),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Mã xác thực đã gửi đến số ',
                                  style: TextStyleCommon.displaySubBody(context,
                                      color: black,
                                      fontSize: 15,
                                      height: 20 / 15),
                                  children: [
                                TextSpan(
                                    text: '0971212312',
                                    style: TextStyleCommon.displayHeader(
                                        context,
                                        color: black,
                                        fontSize: 15,
                                        height: 20 / 15))
                              ])),
                          SizedBox(
                            height: normalize(35),
                          ),
                          const _InputOTPView(),
                          SizedBox(
                            height: normalize(19),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    normalize(generalHorizontalPadding)),
                            child: Text(
                              'OTP quá 5 lần, tài khoản của bạn sẽ bị khóa'
                                  ' trong vòng 24 giờ',
                              textAlign: TextAlign.center,
                              style: TextStyleCommon.displaySubBody(context,
                                  color: black, fontSize: 15, height: 20 / 15),
                            ),
                          ),
                          SizedBox(
                            height: normalize(13),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Gửi lại OTP ',
                                  style: TextStyleCommon.displaySubBody(context,
                                      color: grey9B,
                                      fontSize: 15,
                                      height: 20 / 15),
                                  children: [
                                TextSpan(
                                    text: '(23:59)',
                                    style: TextStyleCommon.displayHeader(
                                        context,
                                        color: black,
                                        fontSize: 15,
                                        height: 20 / 15))
                              ]))
                        ],
                      ),
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

class _InputOTPView extends StatefulWidget {
  const _InputOTPView({Key? key}) : super(key: key);

  @override
  State<_InputOTPView> createState() => _InputOTPViewState();
}

class _InputOTPViewState extends State<_InputOTPView> {
  late StreamController<ErrorAnimationType> errorController;
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: normalize(25), right: normalize(25)),
      child: PinCodeTextField(
        // focusNode: myOTPFocusNode,
        autoFocus: true,
        autoDismissKeyboard: true,
        autoDisposeControllers: true,
        enablePinAutofill: false,
        useExternalAutoFillGroup: true,
        appContext: context,
        pastedTextStyle: TextStyle(
          color: Colors.green.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 4,
        obscureText: false,
        obscuringCharacter: '*',
        showCursor: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(12),
          fieldHeight: normalize(61),
          fieldWidth: normalize(60),
          activeFillColor: white,
          borderWidth: 1,
          activeColor: blue6DFF,
          // errorBorderColor: hasError ? red : greyF4,
          inactiveFillColor: white,
          inactiveColor: greyE0,
          selectedFillColor: white,
          selectedColor: blue6DFF,
        ),
        cursorColor: Colors.black,
        // animationDuration: Duration(milliseconds: 300),
        textStyle: TextStyleCommon.displayHeader(
          context,
          fontSize: 36,
          color: black,
        ),
        // backgroundColor: Colors.blue.shade50,
        enableActiveFill: true,
        errorAnimationController: errorController,
        controller: _otpController,
        keyboardType: TextInputType.number,
        onCompleted: (v) {},
        onChanged: (value) {},
        beforeTextPaste: (text) {
          debugPrint('Allowing to paste $text');
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }
}

class _BottomView extends StatelessWidget {
  const _BottomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthOTPProvider>(builder: (c, provider, child) {
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
          onPressed: () {},
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(
                width: 1.0,
                color: fushiaC8A,
              ),
            ),
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
            'Xác nhận',
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
