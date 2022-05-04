import 'package:picker/data/models/models.dart';

abstract class UserRepository {
  Future<void> saveUserAndAuthorization({
    required User user,
    required Authorization authorization,
  });

  User? getLoggedInUser();

  Future<void> clearUser();

  Authorization? getLoggedInAuthorization();

  Future<void> clearAuthentication();
}
