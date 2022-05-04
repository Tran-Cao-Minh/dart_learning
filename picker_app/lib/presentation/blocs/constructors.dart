import 'package:flutter/foundation.dart';
import 'package:picker/domain/interactors/auth_interactor.dart';
import 'package:picker/injection.dart';

import 'blocs.dart';

final Map<Type, Object Function(Key key)> blocConstructors = {
  ConnectivityBloc: ConnectivityBloc.new,
  LoaderBloc: LoaderBloc.new,
  LoginBloc: (Key key) => LoginBloc(
        key,
        authInteractor: getIt<AuthInteractor>(),
      ),
  VerifyOTPBloc: (Key key) => VerifyOTPBloc(
        key,
        authInteractor: getIt<AuthInteractor>(),
      ),
  ForgotPasswordBloc: (Key key) => ForgotPasswordBloc(
        key,
        authInteractor: getIt<AuthInteractor>(),
      ),
};
