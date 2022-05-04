import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/domain/interactors/auth_interactor.dart';
import 'package:picker/presentation/blocs/base/base_bloc.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';

import '../mixins/mixins.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends BaseBloc<ForgotPasswordEvent, ForgotPasswordState> with AppLoader {
  late final AuthInteractor _authInteractor;

  ForgotPasswordBloc(
    Key key, {
    required AuthInteractor authInteractor,
  })  : _authInteractor = authInteractor,
        super(
          key,
          initialState: ForgotPasswordInitial(),
        ) {
    on<ForgotPasswordSubmitted>(_onPasswordSubmitted);
  }

  factory ForgotPasswordBloc.instance() {
    return EventBus()
        .newBloc<ForgotPasswordBloc>(Keys.Blocs.forgotPasswordBloc);
  }

  Future<void> _onPasswordSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    showAppLoading();
    emit(ForgotPasswordSubmitInProgress());

    try {
      // await _authInteractor.submitResetPassword(
      //   password: event.newPassword,
      //   otpCode: event.otpCode,
      // );

      hideAppLoading();
      emit(ForgotPasswordSubmitSuccess());
    } catch (err) {
      hideAppLoading();
      emit(ForgotPasswordSubmitFailure());
    }
  }
}
