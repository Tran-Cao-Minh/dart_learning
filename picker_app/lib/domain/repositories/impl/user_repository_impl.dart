import 'package:picker/data/datasources/local/user_local_datasource.dart';
import 'package:picker/data/models/authorization.dart';
import 'package:picker/data/models/user.dart';
import 'package:picker/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  late final UserLocalDataSource _userLocalDataSource;

  UserRepositoryImpl({
    required UserLocalDataSource userLocalDataSource,
  }) : _userLocalDataSource = userLocalDataSource;

  @override
  Future<void> clearAuthentication() async {
    return _userLocalDataSource.clearAuthentication();
  }

  @override
  Future<void> clearUser() async {
    return _userLocalDataSource.clearUser();
  }

  @override
  Authorization? getLoggedInAuthorization() {
    return _userLocalDataSource.loadAuthorization();
  }

  @override
  User? getLoggedInUser() {
    return _userLocalDataSource.loadUser();
  }

  @override
  Future<void> saveUserAndAuthorization({
    required User user,
    required Authorization authorization,
  }) async {
    await _userLocalDataSource.saveUser(user);
    await _userLocalDataSource.saveAuthorization(authorization);
  }
}
