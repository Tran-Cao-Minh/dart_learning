import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/domain/interactors/auth_interactor.dart';
import 'package:picker/presentation/blocs/base/base_bloc.dart';
import 'package:picker/presentation/blocs/base/event_bus.dart';
import 'package:picker/presentation/enums/enums.dart';

import '../mixins/mixins.dart';
import 'verify_otp_event.dart';
import 'verify_otp_state.dart';

class VerifyOTPBloc extends BaseBloc<VerifyOTPEvent, VerifyOTPState>
    with AppLoader {
  late final AuthInteractor _authInteractor;

  VerifyOTPBloc(
    Key key, {
    required AuthInteractor authInteractor,
  })  : _authInteractor = authInteractor,
        super(
          key,
          initialState: VerifyOTPInitial(),
        ) {
    on<VerifyOTPCodeRequested>(_onCodeRequested);
    on<VerifyOTPCodeSubmitted>(_onCodeSubmitted);
  }

  factory VerifyOTPBloc.instance() {
    return EventBus().newBloc<VerifyOTPBloc>(Keys.Blocs.verifyOTPBloc);
  }

  Future<void> _onCodeRequested(
    VerifyOTPCodeRequested event,
    Emitter<VerifyOTPState> emit,
  ) async {
    emit(VerifyOTPRequestCodeInProgress());

    try {
      // await _authInteractor.requestCode(
      //   phoneNumber: event.phoneNumber,
      // );

      emit(VerifyOTPRequestCodeSuccess());
    } catch (err) {
      emit(VerifyOTPRequestCodeFailure());
    }
  }

  Future<void> _onCodeSubmitted(
    VerifyOTPCodeSubmitted event,
    Emitter<VerifyOTPState> emit,
  ) async {
    showAppLoading();
    emit(VerifyOTPSubmitCodeInProgress());

    try {
      // await _authInteractor.verifyOTPCode(
      //   phoneNumber: event.phoneNumber,
      //   otpCode: event.otpCode,
      //   otpContext: event.otpContext.toValue(),
      // );

      hideAppLoading();
      emit(VerifyOTPSubmitCodeSuccess(event.otpCode));
    } catch (err) {
      hideAppLoading();
      emit(VerifyOTPSubmitCodeFailure());
    }
  }
}
