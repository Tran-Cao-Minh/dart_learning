import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/blocs/blocs.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'package:picker/presentation/common/route_transition/route_transition.dart';

import '../widgets/auth_login_content.dart';
import '../widgets/auth_submit_button.dart';

extension LoginPasswordScreenTheme on ThemeData {
  TextStyle get loginPasswordBtn => primaryButtonBold.copyWith(
        color: blue1976,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );
}

class LoginPasswordScreen extends StatefulWidget {
  const LoginPasswordScreen({Key? key}) : super(key: key);

  @override
  _LoginPasswordScreenState createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  final FocusScopeNode _formScopeNode = FocusScopeNode();
  final FocusNode _passwordNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  final ValueNotifier<bool> _isEnabledBtn = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _formScopeNode.dispose();
    _passwordNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String get _hintText {
    return 'Nhập mật khẩu';
  }

  void _handleToggle() => setState(() => _isObscure = !_isObscure);

  void _onFieldSubmitted(String _) {
    _formScopeNode.unfocus();
  }

  void _onSubmitPressed() {
    EventBus().event<LoginBloc>(
      Keys.Blocs.loginBloc,
      LoginSubmitted(_passwordController.text.trim()),
    );
  }

  Future<void> _onForgetPasswordTapped() async {
    final phoneNumber = EventBus()
        .blocFromKey<LoginBloc>(Keys.Blocs.loginBloc)!
        .state
        .phoneNumber;
    if (phoneNumber != null) {
      final result = await Navigator.of(context).pushRTLTransition<bool>(
        routeName: Screens.verifyOTP,
        arguments: {
          Keys.AuthJourney.phoneNumber: phoneNumber,
        },
      );
      if (result != null && result) {
        WidgetsBinding.instance!.addPostFrameCallback(
          (_) {
            setState(() {
              _formScopeNode.requestFocus(_passwordNode);
            });
          },
        );
      }
    }
  }

  void _onChanged(String password) {
    _isEnabledBtn.value = password.isValidPasswordLength;
  }

  void _proceedLoggedIn() {
    Navigator.of(context).pushNamedAndRemoveUntil(Screens.home, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is LoginSubmitSuccess) {
          _proceedLoggedIn();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar(
          bgColor: Colors.white,
          elevation: 0.0,
          useDefault: false,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
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
                title: 'Mật khẩu',
                message: 'Mật khẩu do Admin cung cấp cho bạn',
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: FocusScope(
                  node: _formScopeNode,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: dimen_10.h,
                    ),
                    child: MyInputField.single(
                      context,
                      autoFocus: true,
                      bgColor: Colors.white,
                      hintText: _hintText,
                      focusNode: _passwordNode,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: _isObscure,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(
                          left: dimen_10.w,
                          right: dimen_12.w,
                        ),
                        child: InkButton(
                          onTap: _handleToggle,
                          highlightColor: Colors.transparent,
                          width: dimen_32.w,
                          height: dimen_32.w,
                          child: AppIcon(
                            _isObscure ? AppIcons.eyeOn : AppIcons.eyeOff,
                            width: dimen_24.w,
                            height: dimen_24.h,
                          ),
                        ),
                      ),
                      onChanged: _onChanged,
                      onFieldSubmitted: _onFieldSubmitted,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  InkButton(
                    onTap: _onForgetPasswordTapped,
                    height: dimen_32.h,
                    child: Text(
                      'Quên mật khẩu?',
                      style: Theme.of(context).loginPasswordBtn,
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
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
