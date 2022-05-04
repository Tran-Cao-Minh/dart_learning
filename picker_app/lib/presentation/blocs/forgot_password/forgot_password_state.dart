import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordSubmitInProgress extends ForgotPasswordState {
  ForgotPasswordSubmitInProgress() : super();
}

class ForgotPasswordSubmitSuccess extends ForgotPasswordState {
  ForgotPasswordSubmitSuccess() : super();
}

class ForgotPasswordSubmitFailure extends ForgotPasswordState {
  ForgotPasswordSubmitFailure() : super();
}
