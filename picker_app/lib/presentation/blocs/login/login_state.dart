import 'package:equatable/equatable.dart';
import 'package:picker/data/models/models.dart';

abstract class LoginState extends Equatable {
  final String? phoneNumber;

  LoginState({
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
      ];
}

class LoginInitial extends LoginState {}

class LoginVerifyPhoneInProgress extends LoginState {}

class LoginVerifyPhoneSuccess extends LoginState {
  LoginVerifyPhoneSuccess(String phoneNumber) : super(phoneNumber: phoneNumber);
}

class LoginVerifyPhoneFailure extends LoginState {}

class LoginSubmitInProgress extends LoginState {
  LoginSubmitInProgress(String phoneNumber) : super(phoneNumber: phoneNumber);
}

class LoginSubmitSuccess extends LoginState {
  final User userInfo;

  LoginSubmitSuccess({
    required this.userInfo,
  }) : super();
}

class LoginSubmitFailure extends LoginState {
  LoginSubmitFailure(String phoneNumber) : super(phoneNumber: phoneNumber);
}
