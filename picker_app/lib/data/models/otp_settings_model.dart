import 'package:picker/domain/entity/entity.dart';

class OtpSettingModel extends Entity {
  final int maxFailedAttempts;
  final int blockTime;
  final int maxOtpRequestsPerDay;

  OtpSettingModel({
    required this.maxFailedAttempts,
    required this.blockTime,
    required this.maxOtpRequestsPerDay,
  });

  // ignore: prefer_constructors_over_static_methods
  static OtpSettingModel fromJson(Map<String, dynamic> json) {
    return OtpSettingModel(
      maxFailedAttempts: json['max_failed_attempts'],
      blockTime: json['block_time'],
      maxOtpRequestsPerDay: json['max_otp_requests_per_day'],
    );
  }

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic>? toJson() => null;
}
