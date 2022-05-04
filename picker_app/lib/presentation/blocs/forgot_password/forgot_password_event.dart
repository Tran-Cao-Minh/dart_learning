abstract class ForgotPasswordEvent {
  const ForgotPasswordEvent();
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  final String newPassword;
  final String otpCode;

  ForgotPasswordSubmitted({
    required this.newPassword,
    required this.otpCode,
  });
}
