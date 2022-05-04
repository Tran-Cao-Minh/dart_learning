import 'package:flutter/foundation.dart';

class Keys {
  static _Blocs get Blocs => _Blocs();
  static _LoadListInteractors get LoadListInteractors => _LoadListInteractors();
  static _AuthJourney get AuthJourney => _AuthJourney();
}

class _Blocs {
  static final _Blocs _singleton = _Blocs._internal();

  factory _Blocs() {
    return _singleton;
  }

  _Blocs._internal();

  // One instance at the given time
  final Key noneDisposeBloc = const Key('none_dispose_bloc');
  final Key forceToDisposeBloc = const Key('force_to_dispose_bloc');

  final Key connectivityBloc = const Key('connectivity_bloc');
  final Key loaderBloc = const Key('loader_bloc');
  final Key sessionBloc = const Key('session_bloc');
  final Key loginBloc = const Key('login_bloc');
  final Key verifyOTPBloc = const Key('verify_otp_bloc');
  final Key forgotPasswordBloc = const Key('forgot_password_bloc');
}

class _LoadListInteractors {
  static final _LoadListInteractors _singleton =
      _LoadListInteractors._internal();

  factory _LoadListInteractors() {
    return _singleton;
  }

  _LoadListInteractors._internal();

  final String limit = 'limit';
  final String offset = 'offset';
  final String count = 'count';
  final String loadListGroupType = 'loadListGroupType';
}

class _AuthJourney {
  static final _AuthJourney _singleton =
  _AuthJourney._internal();

  factory _AuthJourney() {
    return _singleton;
  }

  _AuthJourney._internal();

  final String phoneNumber = 'phoneNumber';
  final String otpCode = 'otpCode';
}
