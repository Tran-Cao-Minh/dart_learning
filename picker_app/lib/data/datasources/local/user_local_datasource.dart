import 'package:picker/data/models/models.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(User user);

  User? loadUser();

  Future<void> saveAuthorization(Authorization authorization);

  Authorization? loadAuthorization();

  Future<void> clearAuthentication();

  Future<void> clearUser();
}
