import 'package:picker/domain/entity/entity.dart';

class ChangePasswordRequest extends Entity {
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toJson() {
    return {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}
