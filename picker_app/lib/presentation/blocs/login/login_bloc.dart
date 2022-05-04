import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/domain/interactors/auth_interactor.dart';
import 'package:picker/presentation/blocs/base/base_bloc.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';

import '../mixins/mixins.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> with AppLoader {
  late final AuthInteractor _authInteractor;

  LoginBloc(
    Key key, {
    required AuthInteractor authInteractor,
  })  : _authInteractor = authInteractor,
        super(
          key,
          initialState: LoginInitial(),
        ) {
    on<LoginVerifyPhoneStarted>(_onVerifyPhoneStarted);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  factory LoginBloc.instance() {
    return EventBus().newBloc<LoginBloc>(Keys.Blocs.loginBloc);
  }

  Future<void> _onVerifyPhoneStarted(
    LoginVerifyPhoneStarted event,
    Emitter<LoginState> emit,
  ) async {
    showAppLoading();
    emit(LoginVerifyPhoneInProgress());

    try {
      // await _authInteractor.verifyPhoneNumber(
      //   phoneNumber: event.phoneNumber,
      // );

      hideAppLoading();
      emit(LoginVerifyPhoneSuccess(event.phoneNumber));
    } catch (err) {
      hideAppLoading();
      emit(LoginVerifyPhoneFailure());
    }
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    showAppLoading();
    emit(LoginSubmitInProgress(state.phoneNumber!));

    try {
      final userInfo = await _authInteractor.submitLogin(
        phoneNumber: state.phoneNumber!,
        password: event.password,
      );

      hideAppLoading();
      emit(LoginSubmitSuccess(userInfo: userInfo));
    } catch (err) {
      hideAppLoading();
      emit(LoginSubmitFailure(state.phoneNumber!));
    }
  }
}
