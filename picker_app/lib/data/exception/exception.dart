import 'api_error.dart';

class ApiException implements Exception {
  final ApiError _data;

  ApiException(
      Map<String, dynamic> json, {
        String? prefix,
      }) : _data = ApiError.fromJson(json['data']);

  ApiError? get errorData => _data;
}

class AppException implements Exception {
  final String? _message;
  final int? _code;

  AppException(Map<String, dynamic> json)
      : _code = json['code'],
        _message = json['message'];

  @override
  String toString() {
    return '$_code $_message';
  }

  int? get errorCode => _code;

  String get errorMessage => _message ?? 'app_error';
}

class FetchDataException extends ApiException {
  FetchDataException([error])
      : super(error, prefix: 'Error During Communication:');
}

class BadRequestException extends ApiException {
  BadRequestException([error]) : super(error, prefix: 'Invalid Request: ');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([error]) : super(error, prefix: 'Unauthorised: ');
}

class ForbiddenException extends ApiException {
  ForbiddenException([error]) : super(error, prefix: 'Forbidden: ');
}

class NotFoundException extends ApiException {
  NotFoundException([error]) : super(error, prefix: 'Not Found: ');
}

class ServerErrorException extends ApiException {
  ServerErrorException([error]) : super(error, prefix: 'Server Error: ');
}

class InvalidInputException extends ApiException {
  InvalidInputException([error]) : super(error, prefix: 'Invalid Input: ');
}

class InvalidResponseException extends ApiException {
  InvalidResponseException([error])
      : super(error, prefix: 'Invalid Response: ');
}

class UnProcessableEntityException extends ApiException {
  UnProcessableEntityException([error])
      : super(error, prefix: 'UnProcessableEntity Request: ');
}

class ExpiredTokenException extends ApiException {
  ExpiredTokenException([error]) : super(error, prefix: 'Token Expired: ');
}

class NullCastException extends ApiException {
  NullCastException([error])
      : super(error, prefix: 'Null-safety Error: ');
}

class PayloadTooLargeException extends ApiException {
  PayloadTooLargeException([error])
      : super(error, prefix: 'Payload Too Large: ');
}

class ValidationException extends ApiException {
  ValidationException([error]) : super(error, prefix: 'Validation: ');
}
