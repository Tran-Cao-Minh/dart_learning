import 'package:flutter/foundation.dart';
import 'package:picker/data/models/models.dart';
import 'package:picker/domain/repositories/auth_repository.dart';
import 'package:picker/domain/repositories/user_repository.dart';

import '../auth_interactor.dart';

class AuthInteractorImpl extends AuthInteractor {
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  AuthInteractorImpl({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  @override
  Future<void> submitChangePassword({
    required String currentPassword,
    required String newPassword,
  }) async {}

  @override
  Future<void> submitResetPassword({
    required String otpCode,
    required String password,
  }) async {
    final request = ForgetPasswordRequest(
      otpCode: otpCode,
      newPassword: password,
    );
    await _authRepository.submitResetPassword(request: request);
  }

  @override
  Future<User> submitLogin({
    required String phoneNumber,
    required String password,
  }) async {
    final request = LoginRequest(
      phoneNumber: phoneNumber,
      password: password,
    );
    final userInfo = await _authRepository.submitLogin(request: request);

    await _userRepository.saveUserAndAuthorization(
      user: userInfo,
      authorization: Authorization(
        accessToken: userInfo.token ?? 'mock',
      ),
    );

    return userInfo;
  }

  @override
  Future<void> requestCode({
    required String phoneNumber,
  }) async {
    await _authRepository.requestCode(phoneNumber: phoneNumber);
  }

  @override
  Future<void> verifyOTPCode({
    required String phoneNumber,
    required String otpCode,
    required String otpContext,
  }) async {
    final request = VerifyOTPRequest(
      phoneNumber: phoneNumber,
      otpCode: otpCode,
      otpContext: otpContext,
    );
    await _authRepository.verifyOTPCode(request: request);
  }

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    await _authRepository.verifyPhoneNumber(phoneNumber: phoneNumber);
  }
}
