import 'package:get_it/get_it.dart';
import 'package:picker/data/datasources/local/impl/user_local_datasource_impl.dart';
import 'package:picker/data/datasources/local/user_local_datasource.dart';
import 'package:picker/data/datasources/remote/auth_remote_datasource.dart';
import 'package:picker/data/datasources/remote/impl/auth_remote_datasource_impl.dart';
import 'package:picker/data/models/models.dart';
import 'package:picker/domain/interactors/auth_interactor.dart';
import 'package:picker/domain/interactors/impl/auth_interactor_impl.dart';
import 'package:picker/domain/repositories/auth_repository.dart';
import 'package:picker/domain/repositories/impl/auth_repository_impl.dart';
import 'package:picker/domain/repositories/impl/user_repository_impl.dart';
import 'package:picker/domain/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class Injection {
  static final Injection _singleton = Injection._internal();

  factory Injection() {
    return _singleton;
  }

  Injection._internal();

  Authorization? authorization;
  late SharedPreferences _sharedPreferences;

  bool get isAuthorized => authorization != null;

  Future<void> initialize() async {
    /// will apply get real host after configuration run/build with env using cmd.
    const mockBaseHostUrl = 'https://abc.com';
    _sharedPreferences = await SharedPreferences.getInstance();

    // ****** remote data source ****** //
    getIt.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(
        host: mockBaseHostUrl,
        authorization: authorization,
      ),
    );
    // ****** end remote data source ****** //

    // ****** local data source ****** //
    getIt.registerSingleton<UserLocalDataSource>(
      UserLocalDataSourceImpl(
        preferences: _sharedPreferences,
      ),
    );
    // ****** end local data source ****** //

    // ****** repository ****** //
    getIt.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: getIt<AuthRemoteDataSource>(),
      ),
    );

    getIt.registerFactory<UserRepository>(
      () => UserRepositoryImpl(
        userLocalDataSource: getIt<UserLocalDataSource>(),
      ),
    );
    // ****** end repository ****** //

    // ****** interactor ****** //
    getIt.registerFactory<AuthInteractor>(
      () => AuthInteractorImpl(
        authRepository: getIt<AuthRepository>(),
        userRepository: getIt<UserRepository>(),
      ),
    );
    // ****** end interactor ****** //
  }
}
