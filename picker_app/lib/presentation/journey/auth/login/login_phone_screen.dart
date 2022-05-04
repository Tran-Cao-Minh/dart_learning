import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/blocs/blocs.dart';
import 'package:picker/presentation/common/route_transition/route_transition.dart';
import 'package:picker/presentation/theme/theme.dart';

import '../widgets/auth_login_content.dart';
import '../widgets/auth_submit_button.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({Key? key}) : super(key: key);

  @override
  _LoginPhoneScreenState createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  final FocusScopeNode _formScopeNode = FocusScopeNode();
  final FocusNode _phoneNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  final ValueNotifier<bool> _isEnabledBtn = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _formScopeNode.dispose();
    _phoneNode.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String get _hintText {
    return 'Nhập số điện thoại';
  }

  String? _onPhoneValidator(String? phone) {
    if (!phone.isValidPhoneNumber) {
      return 'Số điện thoại không đúng.';
    }

    return null;
  }

  void _onChanged(String phone) {
    _isEnabledBtn.value = phone.isValidPhoneNumber;

    if (phone.length >= 12) {
      _formKey.currentState!.validate();
    }
  }

  void _onFieldSubmitted(String _) {
    _formScopeNode.unfocus();
  }

  void _onSubmitPressed() {
    _formKey.currentState!.validate();

    if (!_phoneController.text.isValidPhoneNumber) {
      return;
    }

    EventBus().event<LoginBloc>(
      Keys.Blocs.loginBloc,
      LoginVerifyPhoneStarted(_phoneController.text.trim()),
    );
  }

  void _proceedPhoneVerified() {
    Navigator.of(context).pushRTLTransition(routeName: Screens.loginPassword);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (prevState, currentState) =>
          currentState is LoginVerifyPhoneSuccess ||
          currentState is LoginVerifyPhoneFailure,
      listener: (_, state) {
        if (state is LoginVerifyPhoneSuccess) {
          _proceedPhoneVerified();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar(
          bgColor: Colors.white,
          elevation: 0.0,
          useDefault: false,
          titleSpacing: 0.0,
          customTitle: const Expanded(
            child: SizedBox.shrink(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dimen_16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthLoginContent(
                title: 'Số điện thoại',
                message: 'Nhập số điện thoại đã đăng ký với QLTT',
              ),
              Form(
                key: _formKey,
                child: FocusScope(
                  node: _formScopeNode,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: dimen_10.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: dimen_52.w,
                          height: dimen_48.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: dimen_1,
                              color: greyBBBC,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(dimen_8),
                          ),
                          child: Center(
                            child: LoadAssetImage(
                              AppImagesAsset.vietnamFlag,
                              width: dimen_24.w,
                              height: dimen_24.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dimen_10.w,
                        ),
                        Expanded(
                          child: MyInputField.single(
                            context,
                            hintText: _hintText,
                            focusNode: _phoneNode,
                            autoFocus: true,
                            showClearButton: true,
                            inputFormatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              PhoneNumberFormatter(),
                            ],
                            bgColor: Colors.white,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            controller: _phoneController,
                            validator: _onPhoneValidator,
                            onChanged: _onChanged,
                            onFieldSubmitted: _onFieldSubmitted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isEnabledBtn,
                builder: (_, value, child) {
                  return LoginSubmitButton(
                    isEnabled: value,
                    onPressed: _onSubmitPressed,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
