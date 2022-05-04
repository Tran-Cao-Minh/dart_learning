enum OTPContext { forgotPassword, }

extension OTPContextExtension on OTPContext {
  String toValue() {
    if (this == OTPContext.forgotPassword) {
      return 'forgot_password';
    }

    return 'undefined';
  }
}
