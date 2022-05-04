import 'package:picker/data/models/models.dart';
import '../auth_remote_datasource.dart';
import '../base_remote_datasource.dart';

class AuthRemoteDataSourceImpl extends BaseRemoteDataSource
    implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required String host,
    Authorization? authorization,
  }) : super(
          host,
          authorization: authorization,
        );

  @override
  Future<void> submitResetPassword({
    required ForgetPasswordRequest request,
  }) async {}

  @override
  Future<void> changePassword({
    required ChangePasswordRequest request,
  }) async {}

  @override
  Future<void> submitLogin({
    required LoginRequest request,
  }) async {}

  @override
  Future<void> verifyOTPCode({
    required VerifyOTPRequest request,
  }) async {}

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
  }) async {}

  @override
  Future<void> requestCode({
    required String phoneNumber,
  }) async {}
}
