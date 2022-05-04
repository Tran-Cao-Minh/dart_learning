import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/common/widgets/my_input_field.dart';
import 'package:picker/route/route_constant.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';
import 'package:provider/provider.dart';

import 'provider/auth_password_provider.dart';

class AuthPasswordScreen extends StatelessWidget {
  const AuthPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthPasswordProvider>(
      create: (c) => AuthPasswordProvider(),
      builder: (_, __) => const _AuthPasswordConsumer(),
    );
  }
}

class _AuthPasswordConsumer extends StatefulWidget {
  const _AuthPasswordConsumer({Key? key}) : super(key: key);

  @override
  State<_AuthPasswordConsumer> createState() => __AuthPasswordScreenState();
}

class __AuthPasswordScreenState extends State<_AuthPasswordConsumer> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _passwordFFS = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mật khẩu',
                            style: TextStyleCommon.displayHeader(context,
                                color: black, fontSize: 30, height: 38 / 30),
                          ),
                          SizedBox(
                            height: normalize(10),
                          ),
                          Text(
                            'Mật khẩu do Admin cung cấp cho bạn',
                            style: TextStyleCommon.displaySubBody(context,
                                color: black, fontSize: 16, height: 20 / 16),
                          ),
                          SizedBox(
                            height: normalize(25),
                          ),
                          Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            onChanged: () {
                              ///
                              ///
                              ///
                            },
                            child: MyInputField(
                              controller: _phoneController,
                              textFormKey: _passwordFFS,
                              obscureText: true,
                              hint: 'Mật khẩu',
                              isPassword: true,
                              textInputType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            height: normalize(19),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RouteConstant.forgetPassword);
                            },
                            child: Text(
                              'Quên mật khẩu',
                              style: TextStyleCommon.displayHeader(context,
                                  color: blueFF,
                                  fontSize: 16,
                                  height: 18.75 / 16),
                            ),
                          )
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

class _BottomView extends StatelessWidget {
  const _BottomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthPasswordProvider>(builder: (c, provider, child) {
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
            Navigator.of(context).pushNamed(RouteConstant.authOTP);
          },
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                width: 1.0,
                color: provider.isPasswordInvalid ? grey3A : fushiaC8A,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (provider.isPasswordInvalid) {
                  return grey3A;
                }
                return fushiaC8A;
              },
            ),
          ),
          child: Text(
            'Gửi mã xác nhận',
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
