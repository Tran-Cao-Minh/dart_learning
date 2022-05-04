import 'package:picker/domain/entity/entity.dart';

class VerifyOTPRequest extends Entity {
  final String phoneNumber;
  final String otpCode;
  final String otpContext;

  VerifyOTPRequest({
    required this.phoneNumber,
    required this.otpCode,
    required this.otpContext,
  });

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'otpCode': otpCode,
      'otpContext': otpContext,
    };
  }
}
