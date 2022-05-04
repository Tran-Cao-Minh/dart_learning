import 'package:picker/domain/entity/entity.dart';

class Authorization extends Entity {
  final String accessToken;

  // ignore: prefer_constructors_over_static_methods
  static Authorization fromJson(Map<String, dynamic> json) {
    return Authorization(
      accessToken: json['token'],
    );
  }

  Authorization({
    required this.accessToken,
  });

  @override
  List<Object> get props => [
    accessToken,
  ];

  @override
  Map<String, dynamic> toJson() => {
    'token': accessToken,
  };
}