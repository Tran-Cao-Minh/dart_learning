import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:picker/common/widgets/my_input_field.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';
import 'package:provider/provider.dart';

import 'forget_password_provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => ForgetPasswordProvider(),
      child: const _ForgetPasswordConsumer(),
    );
  }
}

class _ForgetPasswordConsumer extends StatefulWidget {
  const _ForgetPasswordConsumer({Key? key}) : super(key: key);

  @override
  State<_ForgetPasswordConsumer> createState() =>
      __ForgetPasswordConsumerState();
}

class __ForgetPasswordConsumerState extends State<_ForgetPasswordConsumer> {
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
                            'Nhập mật khẩu mới',
                            style: TextStyleCommon.displayHeader(context,
                                color: black, fontSize: 30, height: 38 / 30),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: normalize(generalHorizontalPadding),
                              left: normalize(generalHorizontalPadding)),
                          child: Text(
                            'Thiết lập mật khẩu bảo mật mới',
                            style: TextStyleCommon.displaySubBody(context,
                                color: black, fontSize: 16, height: 20 / 16),
                          ),
                        ),
                        SizedBox(
                          height: normalize(21),
                        ),
                        const _InputPasswordView(),
                        SizedBox(
                          height: normalize(19),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: normalize(24), left: normalize(24)),
                          child: Text(
                            'Mật khẩu mới phải bao gồm ít nhất 8 ký tự, cả chữ cái và chữ số',
                            textAlign: TextAlign.center,
                            style: TextStyleCommon.displaySubBody(context,
                                fontSize: 15),
                          ),
                        )
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

class _InputPasswordView extends StatefulWidget {
  const _InputPasswordView({Key? key}) : super(key: key);

  @override
  State<_InputPasswordView> createState() => __InputPasswordViewState();
}

class __InputPasswordViewState extends State<_InputPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _repeatPasswordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _repeatPasswordController.dispose();

    _passwordFocus.dispose();
    _repeatPasswordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: generalHorizontalPadding),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        onChanged: () {
          ///
          ///
          ///
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyInputField(
              hint: 'Mật khẩu',
              controller: _passwordController,
              focusNode: _passwordFocus,
              obscureText: true,
              isPassword: true,
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: normalize(16),
            ),
            MyInputField(
              hint: 'Nhập lại mật khẩu',
              controller: _repeatPasswordController,
              focusNode: _repeatPasswordFocus,
              obscureText: true,
              isPassword: true,
              textInputType: TextInputType.number,
            )
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
    return Consumer<ForgetPasswordProvider>(builder: (c, provider, child) {
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
            'Tiếp tục',
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
