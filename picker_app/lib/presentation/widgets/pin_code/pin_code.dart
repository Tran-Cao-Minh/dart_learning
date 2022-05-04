import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picker/common/common.dart';
import 'package:picker/mixin/mixin.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'time_count.dart';

extension PinCodeTheme on ThemeData {
  TextStyle get pinCodeTextStyle => primaryNumber.copyWith(
        fontSize: dimen_24.sp,
        height: dimen_32.sp.toLineHeight(dimen_24.sp),
      );

  TextStyle get pinCodeError => primaryBodyMedium.copyWith(
        color: redE70D,
        fontSize: dimen_16.sp,
        height: dimen_30.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get pinCodeWarning => primaryBodyMedium.copyWith(
        color: black6666,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get pinCodeWarningBold => primaryBodyMediumBold.copyWith(
        color: black6666,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );
}

class PinCode extends StatefulWidget {
  final Function? onPressedResend;
  final Function(String text)? onCompleted;
  final void Function(String Text)? onChanged;
  final int secondsNumber;
  final int maxTile;
  final bool hasError;
  final double fieldWidth;
  final double fieldHeight;
  final FocusScopeNode formScopeNode;
  final FocusNode pinNode;
  final GlobalKey<FormState> formKey;
  final TextEditingController otpCodeController;
  final bool shouldEnableResend;

  PinCode({
    Key? key,
    this.onCompleted,
    this.onPressedResend,
    this.onChanged,
    required this.secondsNumber,
    this.maxTile = 4,
    this.hasError = false,
    required this.fieldWidth,
    required this.fieldHeight,
    required this.formScopeNode,
    required this.formKey,
    required this.pinNode,
    required this.otpCodeController,
    this.shouldEnableResend = false,
  }) : super(key: key);

  @override
  _PinCodeState createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode>
    with WidgetDidMount<PinCode>, WidgetsBindingObserver {
  late bool _isTimerRunning;
  late double _circleProgressVal;
  late int _secondCounter;
  late Timer _timer;
  late bool _shouldEnableResend;
  late bool _hasError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    _isTimerRunning = false;
    _circleProgressVal = 1.0;
    _secondCounter = widget.secondsNumber;
    _shouldEnableResend = widget.shouldEnableResend;
    _hasError = widget.hasError;
    if (!_isTimerRunning) {
      _isTimerRunning = true;
      _updateProgress();
    }
  }

  @override
  void widgetDidMount(BuildContext context) {
    setState(() {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => widget.formScopeNode.requestFocus(widget.pinNode),
      );
    });
  }

  @override
  void didUpdateWidget(PinCode oldWidget) {
    if (oldWidget.shouldEnableResend != widget.shouldEnableResend) {
      setState(() {
        _shouldEnableResend = !_shouldEnableResend;
      });
    }

    if (oldWidget.hasError != widget.hasError) {
      setState(() {
        _hasError = !_hasError;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          WidgetsBinding.instance!.addPostFrameCallback(
            (_) => widget.formScopeNode.requestFocus(widget.pinNode),
          );
        }
        break;
      case AppLifecycleState.inactive:
        widget.formScopeNode.unfocus();
        break;
      case AppLifecycleState.paused:
        widget.formScopeNode.unfocus();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  void _updateProgress() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (Timer timer) {
      _secondCounter -= 1;
      _circleProgressVal -= 1 / widget.secondsNumber;
      _shouldEnableResend = _secondCounter < 90;
      if (_secondCounter == 0) {
        timer.cancel();
        _stopTimer();
      }

      setState(() {});
    });
  }

  void _stopTimer() {
    _timer.cancel();
    _secondCounter = widget.secondsNumber;
    setState(() {
      _isTimerRunning = false;
      _circleProgressVal = 1.0;
    });
  }

  void _onPressResend() {
    if (!_isTimerRunning) {
      widget.onPressedResend?.call();
      setState(() {
        _isTimerRunning = true;
      });
      _updateProgress();
    }
  }

  void _onChangedText(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    } else {
      setState(() {});
    }
  }

  void _onCompleted(String value) {
    if (value.length == widget.maxTile) {
      widget.onCompleted?.call(value);
    }
  }

  String get _textQuery {
    return '5 lần';
  }

  String get _message {
    return 'OTP quá 5 lần, tài khoản của bạn sẽ bị khóa trong vòng 24 giờ';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: dimen_32.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dimen_40.w,
          ),
          child: Form(
            key: widget.formKey,
            child: FocusScope(
              node: widget.formScopeNode,
              child: Container(
                height: dimen_64.h,
                child: PinCodeTextField(
                  appContext: context,
                  textStyle: Theme.of(context).pinCodeTextStyle,
                  length: widget.maxTile,
                  obscureText: false,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  focusNode: widget.pinNode,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderWidth: dimen_1,
                    borderRadius: BorderRadius.circular(dimen_8),
                    fieldWidth: widget.fieldWidth,
                    fieldHeight: widget.fieldHeight,
                    inactiveColor: widget.hasError ? redE70D : blackCCCC,
                    selectedColor: widget.hasError ? redE70D : blue1976,
                    activeColor: widget.hasError ? redE70D : blue1976,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    activeFillColor: Colors.white,
                  ),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  autoDismissKeyboard: false,
                  controller: widget.otpCodeController,
                  onCompleted: _onCompleted,
                  animationType: AnimationType.none,
                  onChanged: _onChangedText,
                  pastedTextStyle: const TextStyle(
                    color: black3333,
                    fontWeight: FontWeight.bold,
                  ),
                  beforeTextPaste: (text) {
                    debugPrint('Allowing to paste $text');
                    //if you return true then it will show the paste
                    // confirmation dialog. Otherwise if false,
                    // then nothing will happen.
                    //but you can show anything you want here,
                    // like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
            ),
          ),
        ),
        if (_hasError)
          Padding(
            padding: EdgeInsets.only(
              top: dimen_16.h,
            ),
            child: Text(
              'Mã OTP ko đúng',
              style: Theme.of(context).pinCodeError,
              textAlign: TextAlign.center,
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: dimen_16.h,
          ),
          child: MyTextSpan(
            text: _message.toMapQueryToTextTag(
              textQuery: _textQuery,
              startTag: Tag.startBold,
              endTag: Tag.endBold,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            defaultStyle: Theme.of(context).pinCodeWarning,
            boldStyle: Theme.of(context).pinCodeWarningBold,
          ),
        ),
        PinCodeTimeCount(
          progressVal: _circleProgressVal,
          timeString: _secondCounter.prepareResendTime,
          shouldEnableResend: _shouldEnableResend,
          onResendTapped: _shouldEnableResend ? _onPressResend : null,
        ),
      ],
    );
  }
}
