import 'package:picker/data/models/otp_settings_model.dart';

abstract class ConfigRepository {
  Future<OtpSettingModel> getOtpSetting();
}
