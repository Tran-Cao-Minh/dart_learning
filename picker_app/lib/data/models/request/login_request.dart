import 'package:picker/domain/entity/entity.dart';

class LoginRequest extends Entity {
  final String phoneNumber;
  final String password;

  LoginRequest({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
