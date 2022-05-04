import 'package:equatable/equatable.dart';

abstract class VerifyOTPState extends Equatable {
  VerifyOTPState();

  @override
  List<Object> get props => [];
}

class VerifyOTPInitial extends VerifyOTPState {
  VerifyOTPInitial() : super();
}

class VerifyOTPRequestCodeInProgress extends VerifyOTPState {
  VerifyOTPRequestCodeInProgress() : super();
}

class VerifyOTPRequestCodeSuccess extends VerifyOTPState {
  VerifyOTPRequestCodeSuccess() : super();
}

class VerifyOTPRequestCodeFailure extends VerifyOTPState {
  VerifyOTPRequestCodeFailure() : super();
}

class VerifyOTPSubmitCodeInProgress extends VerifyOTPState {
  VerifyOTPSubmitCodeInProgress() : super();
}

class VerifyOTPSubmitCodeSuccess extends VerifyOTPState {
  final String otpCode;

  VerifyOTPSubmitCodeSuccess(this.otpCode) : super();
}

class VerifyOTPSubmitCodeFailure extends VerifyOTPState {
  VerifyOTPSubmitCodeFailure() : super();
}
