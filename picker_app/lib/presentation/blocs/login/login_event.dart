abstract class LoginEvent {
  const LoginEvent();
}

class LoginVerifyPhoneStarted extends LoginEvent {
  final String phoneNumber;

  LoginVerifyPhoneStarted(this.phoneNumber);
}

class LoginSubmitted extends LoginEvent {
  final String password;

  LoginSubmitted(this.password);
}
