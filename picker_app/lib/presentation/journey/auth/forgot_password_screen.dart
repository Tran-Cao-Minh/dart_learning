import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/blocs/blocs.dart';
import 'package:picker/presentation/journey/auth/widgets/auth_login_content.dart';
import 'package:picker/presentation/journey/auth/widgets/auth_submit_button.dart';
import 'package:picker/presentation/theme/theme.dart';

extension ForgotPasswordScreenTheme on ThemeData {
  TextStyle get forgotPasswordMessage => primaryBodySmall.copyWith(
        fontSize: dimen_14.sp,
        height: dimen_20.sp.toLineHeight(dimen_14.sp),
      );
}

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({
    Key? key,
    required this.otpCode,
  }) : super(key: key);

  final String otpCode;

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FocusScopeNode _formScopeNode = FocusScopeNode();
  final FocusNode _passwordNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _confirmPasswordNode = FocusNode();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isObscure = true;
  bool _isConfirmObscure = true;
  final ValueNotifier<bool> _isEnabledBtn = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _formScopeNode.dispose();
    _passwordNode.dispose();
    _passwordController.dispose();
    _confirmPasswordNode.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleToggle() => setState(() => _isObscure = !_isObscure);

  void _handleConfirmToggle() =>
      setState(() => _isConfirmObscure = !_isConfirmObscure);

  String get _hintText {
    return 'Nhập mật khẩu';
  }

  String get _confirmHintText {
    return 'Nhập lại mật khẩu';
  }

  void _onFieldSubmitted(String _) {
    _formScopeNode.unfocus();
  }

  void _onEditingComplete() {
    if (_passwordController.text
        .isSamePassword(_confirmPasswordController.text)) {}
    _formScopeNode.requestFocus(_confirmPasswordNode);
  }

  String? _onConfirmPasswordValidator(String? confirmPassword) {
    if (confirmPassword == null) {
      return 'Something went wrong.';
    }

    if (!_passwordController.text.isValidPasswordLength ||
        !confirmPassword.isValidPasswordLength) {
      return 'Mật khẩu không đủ 8 ký tự.';
    }

    if (!_passwordController.text.isValidCharacterPassword ||
        !confirmPassword.isValidCharacterPassword) {
      return 'Mật khẩu phải chứa cả chữ cái và số.';
    }

    if (!confirmPassword.isSamePassword(_passwordController.text)) {
      return 'Mật khẩu không khớp. Vui lòng nhập lại';
    }

    return null;
  }

  void _onConfirmPasswordChanged(String val) {
    _formKey.currentState!.validate();
    _isEnabledBtn.value = val.isSamePassword(_passwordController.text);
  }

  void _onSubmitPressed() {
    if (_confirmPasswordController.text
            .isSamePassword(_passwordController.text) &&
        _confirmPasswordController.text.isValidCharacterPassword &&
        _confirmPasswordController.text.isValidPasswordLength) {
      EventBus().event<ForgotPasswordBloc>(
        Keys.Blocs.forgotPasswordBloc,
        ForgotPasswordSubmitted(
          newPassword: _confirmPasswordController.text.trim(),
          otpCode: widget.otpCode,
        ),
      );
    }
  }

  void _processPasswordCreated() {
    Navigator.popUntil(context, ModalRoute.withName(Screens.loginPhone));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (_, state) {
        if (state is ForgotPasswordSubmitSuccess) {
          _processPasswordCreated();
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
                title: 'Nhập mật khẩu mới',
                message: 'Thiết lập mật khẩu bảo mật mới',
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: FocusScope(
                  node: _formScopeNode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyInputField.single(
                        context,
                        autoFocus: true,
                        bgColor: Colors.white,
                        hintText: _hintText,
                        focusNode: _passwordNode,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
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
                        onEditingComplete: _onEditingComplete,
                      ),
                      SizedBox(
                        height: dimen_10.h,
                      ),
                      MyInputField.single(
                        context,
                        bgColor: Colors.white,
                        hintText: _confirmHintText,
                        focusNode: _confirmPasswordNode,
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: _isConfirmObscure,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: dimen_10.w,
                            right: dimen_12.w,
                          ),
                          child: InkButton(
                            onTap: _handleConfirmToggle,
                            highlightColor: Colors.transparent,
                            width: dimen_32.w,
                            height: dimen_32.w,
                            child: AppIcon(
                              _isConfirmObscure
                                  ? AppIcons.eyeOn
                                  : AppIcons.eyeOff,
                              width: dimen_24.w,
                              height: dimen_24.h,
                            ),
                          ),
                        ),
                        validator: _onConfirmPasswordValidator,
                        onFieldSubmitted: _onFieldSubmitted,
                        onChanged: _onConfirmPasswordChanged,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: dimen_10.h,
                ),
                child: Text(
                  'Mật khẩu mới phải bao gồm ít nhất 8 ký '
                  'tự, cả chữ cái và chữ số',
                  style: Theme.of(context).forgotPasswordMessage,
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
