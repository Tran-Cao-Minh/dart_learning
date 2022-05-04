
import 'package:picker/data/models/models.dart';

abstract class AuthInteractor {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
  });

  Future<User> submitLogin({
    required String phoneNumber,
    required String password,
  });

  Future<void> requestCode({
    required String phoneNumber,
  });

  Future<void> verifyOTPCode({
    required String phoneNumber,
    required String otpCode,
    required String otpContext,
  });

  Future<void> submitResetPassword({
    required String otpCode,
    required String password,
  });

  Future<void> submitChangePassword({
    required String currentPassword,
    required String newPassword,
  });
}