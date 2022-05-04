import 'package:picker/domain/entity/entity.dart';

class ForgetPasswordRequest extends Entity {
  final String otpCode;
  final String newPassword;

  ForgetPasswordRequest({
    required this.otpCode,
    required this.newPassword,
  });

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toJson() {
    return {
      'otpCode': otpCode,
      'newPassword': newPassword,
    };
  }
}
