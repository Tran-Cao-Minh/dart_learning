import 'package:picker/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_local_datasource.dart';
import '../user_local_datasource.dart';

const _CurrentUserKey = 'key_current_user';
const _CurrentAuthorizationKey = 'key_current_authorization';

class UserLocalDataSourceImpl extends BaseLocalDataSource<User>
    implements UserLocalDataSource {
  UserLocalDataSourceImpl({
    required SharedPreferences preferences,
  }) : super(
          mapper: Mapper<User>(parse: User.fromJson),
          prefs: preferences,
        );

  @override
  User? loadUser() {
    return getItem(_CurrentUserKey);
  }

  @override
  Future<void> saveUser(User user) {
    return saveItem(user, _CurrentUserKey);
  }

  @override
  Future<void> saveAuthorization(Authorization authorization) {
    return saveEntity(authorization, _CurrentAuthorizationKey);
  }

  @override
  Future<void> clearAuthentication() async {
    await clearObjectOrEntity(_CurrentAuthorizationKey);
  }

  @override
  Future<void> clearUser() async {
    await clearObjectOrEntity(_CurrentUserKey);
  }

  @override
  Authorization? loadAuthorization() {
    final authorization = getEntity<Authorization>(
      _CurrentAuthorizationKey,
      mapper: Mapper<Authorization>(parse: Authorization.fromJson),
    );

    return authorization;
  }
}
