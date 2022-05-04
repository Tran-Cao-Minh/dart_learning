import 'package:picker/domain/entity/entity.dart';

class User extends Entity {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? token;

  // ignore: prefer_constructors_over_static_methods
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
    );
  }

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.token,
  });

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
      ];

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
      };
}
