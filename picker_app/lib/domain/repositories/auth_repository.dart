import 'package:picker/data/models/models.dart';

abstract class AuthRepository {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
  });

  Future<User> submitLogin({
    required LoginRequest request,
  });

  Future<void> requestCode({
    required String phoneNumber,
  });

  Future<void> verifyOTPCode({
    required VerifyOTPRequest request,
  });

  Future<void> submitResetPassword({
    required ForgetPasswordRequest request,
  });

  Future<void> changePassword({
    required ChangePasswordRequest request,
  });
}
