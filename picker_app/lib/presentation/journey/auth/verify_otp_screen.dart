import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/blocs/blocs.dart';
import 'package:picker/presentation/enums/enums.dart';
import 'package:picker/presentation/journey/auth/widgets/auth_submit_button.dart';
import 'package:picker/presentation/widgets/widgets.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'package:picker/presentation/common/route_transition/route_transition.dart';

extension LoginOTPScreenTheme on ThemeData {
  TextStyle get loginOTPScreenTitle => primaryHeadlineMediumBold.copyWith(
        fontSize: dimen_30.sp,
        height: dimen_38.sp.toLineHeight(dimen_30.sp),
      );

  TextStyle get loginOTPScreenPhoneLabel => primaryBodyMedium.copyWith(
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get loginOTPScreenPhone => primaryBodyMediumBold.copyWith(
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );
}

class VerifyOTPScreen extends StatefulWidget {
  VerifyOTPScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final FocusNode _pinNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinCodeController = TextEditingController();
  String otpCodeInput = '';
  final ValueNotifier<bool> _isEnabledBtn = ValueNotifier<bool>(false);
  bool _shouldEnableResend = false;

  bool _hasError(VerifyOTPState state) {
    return state is VerifyOTPSubmitCodeFailure;
  }

  void _onChanged(String otp) {
    _isEnabledBtn.value = otp.length == 4;
  }

  Future<void> _onComplete(String val) async {
    setState(() {
      otpCodeInput = val;
    });
  }

  void _onBackPressed() {
    Navigator.of(context).pop(true);
  }

  void _onPressedResend() {}

  void _proceedVerifyCodeSuccess(VerifyOTPSubmitCodeSuccess state) {
    Navigator.of(context).pushRTLTransition(
      routeName: Screens.forgotPassword,
      arguments: {
        Keys.AuthJourney.otpCode: state.otpCode,
      },
    );
  }

  void _proceedVerifyCodeFailure() {
    _pinCodeController.clear();
    setState(() {
      _shouldEnableResend = true;
    });
  }

  void _onSubmitPressed() {
    EventBus().event<VerifyOTPBloc>(
      Keys.Blocs.verifyOTPBloc,
      VerifyOTPCodeSubmitted(
        otpContext: OTPContext.forgotPassword,
        otpCode: otpCodeInput,
        phoneNumber: widget.phoneNumber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyOTPBloc, VerifyOTPState>(
      listener: (_, state) {
        if (state is VerifyOTPSubmitCodeSuccess) {
          _proceedVerifyCodeSuccess(state);
        } else if (state is VerifyOTPSubmitCodeFailure) {
          _proceedVerifyCodeFailure();
        }
      },
      child: Scaffold(
        appBar: MyAppBar(
          bgColor: Colors.white,
          elevation: 0.0,
          useDefault: false,
          titleSpacing: 0.0,
          isCallPop: false,
          onBackPressed: _onBackPressed,
          customTitle: const Expanded(
            child: SizedBox.shrink(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dimen_16.w,
          ),
          child: Column(
            children: [
              SizedBox(
                height: dimen_8.h,
              ),
              Text(
                'Nhập mã xác thực OTP',
                style: Theme.of(context).loginOTPScreenTitle,
              ),
              SizedBox(
                height: dimen_8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mã xác thực đã gửi đến số ',
                    style: Theme.of(context).loginOTPScreenPhoneLabel,
                  ),
                  Text(
                    widget.phoneNumber,
                    style: Theme.of(context).loginOTPScreenPhone,
                  ),
                ],
              ),
              BlocBuilder<VerifyOTPBloc, VerifyOTPState>(
                builder: (_, state) {
                  return PinCode(
                    formKey: _formKey,
                    formScopeNode: _focusScopeNode,
                    pinNode: _pinNode,
                    hasError: _hasError(state),
                    otpCodeController: _pinCodeController,
                    shouldEnableResend: _shouldEnableResend,
                    secondsNumber: 120,
                    fieldWidth: dimen_56.w,
                    fieldHeight: dimen_56.w,
                    onCompleted: _onComplete,
                    onChanged: _onChanged,
                    onPressedResend: _onPressedResend,
                  );
                },
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
