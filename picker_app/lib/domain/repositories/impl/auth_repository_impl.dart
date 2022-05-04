import 'package:picker/data/datasources/remote/auth_remote_datasource.dart';
import 'package:picker/data/models/models.dart';
import 'package:picker/domain/test_data.dart';

import '../auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  late final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<void> submitResetPassword({
    required ForgetPasswordRequest request,
  }) async {
    await _authRemoteDataSource.submitResetPassword(
      request: request,
    );
  }

  @override
  Future<void> changePassword({
    required ChangePasswordRequest request,
  }) async {}

  @override
  Future<User> submitLogin({
    required LoginRequest request,
  }) async {
    // final response = await _authRemoteDataSource.submitLogin(
    //   request: request,
    // );
    final response = await TestData.submitLogin();

    return response;
  }

  @override
  Future<void> verifyOTPCode({
    required VerifyOTPRequest request,
  }) async {
    await _authRemoteDataSource.verifyOTPCode(
      request: request,
    );
  }

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    await _authRemoteDataSource.verifyPhoneNumber(
      phoneNumber: phoneNumber,
    );
  }

  @override
  Future<void> requestCode({
    required String phoneNumber,
  }) async {
    await _authRemoteDataSource.requestCode(
      phoneNumber: phoneNumber,
    );
  }
}
