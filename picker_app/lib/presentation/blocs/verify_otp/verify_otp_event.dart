import 'package:picker/presentation/enums/enums.dart';

abstract class VerifyOTPEvent {
  const VerifyOTPEvent();
}

class VerifyOTPCodeRequested extends VerifyOTPEvent {
  VerifyOTPCodeRequested();
}

class VerifyOTPCodeSubmitted extends VerifyOTPEvent {
  final String otpCode;
  final String phoneNumber;
  final OTPContext otpContext;

  VerifyOTPCodeSubmitted({
    required this.otpCode,
    required this.phoneNumber,
    required this.otpContext,
  });
}
