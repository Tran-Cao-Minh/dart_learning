import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:picker/data/exception/exception.dart';
import 'package:picker/data/models/models.dart';
import 'package:picker/injection.dart';
import 'package:retry/retry.dart';
import 'package:picker/common/common.dart';

const defaultErrorJson = '{"data": {"message": "Error occurred while '
    'Communication with Server with StatusCode"}}';

const payloadTooLargeErrorJson = '{"data": {"message": "Payload too large"}}';

abstract class BaseRemoteDataSource {
  late Client _client;
  late String _host;
  Authorization? _authorization;

  BaseRemoteDataSource(
    String host, {
    Client? client,
    Authorization? authorization,
  }) {
    _client = client ?? Client();
    _host = host;
    _authorization = authorization;
  }

  Uri _getParsedUrl(String path) {
    return Uri.parse('$_host$path');
  }

  Future<bool> _refreshToken() async {
    try {
      final authorization = Injection().authorization;
      if (authorization != null) {
        final params = {};

        final response = await _client.post(_getParsedUrl('/dasdasdasd'),
            body: jsonEncode(params));

        if (response.statusCode == 201) {
          return jsonDecode(response.body);
        }

        return false;
      }

      return false;
    } catch (e) {
      debugPrint('Refresh Token Error: $e');
    }

    return false;
  }

  BaseRequest _copyRequest(BaseRequest request) {
    BaseRequest requestCopy;

    if (request is Request) {
      requestCopy = Request(request.method, request.url)
        ..encoding = request.encoding
        ..bodyBytes = request.bodyBytes;
    } else if (request is MultipartRequest) {
      requestCopy = MultipartRequest(request.method, request.url)
        ..fields.addAll(request.fields)
        ..files.addAll(request.files);
    } else if (request is StreamedRequest) {
      throw Exception('copying streamed requests is not supported');
    } else {
      throw Exception('request type is unknown, cannot copy');
    }

    requestCopy
      ..persistentConnection = request.persistentConnection
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..headers.addAll(request.headers);

    return requestCopy;
  }

  dynamic _call(
    String method,
    String path, {
    Map<String, Object?>? data,
  }) async {
    debugPrint(
        'Call API >> $method >> url: ${_getParsedUrl(path)} >> body: $data');
    dynamic responseJson;
    var numberAttempts = 0;
    try {
      var request = Request(method, _getParsedUrl(path));
      if (_authorization != Injection().authorization) {
        _authorization = Injection().authorization;
      }

      final token = (_authorization ?? Injection().authorization)?.accessToken;

      // debugPrint('accessToken: $token');
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
        if (method == 'POST' || method == 'PATCH') {
          request.headers['content-type'] = 'application/json';
          if (data != null) {
            request.body = jsonEncode(data);
          }
        }
      }

      if (method == 'POST' || method == 'PATCH') {
        request.headers['content-type'] = 'application/json';
        if (data != null) {
          request.body = jsonEncode(data);
        }
      }
      responseJson = await retry(() async {
        final response = await _client
            .send(request)
            .timeout(const Duration(seconds: 120))
            .then(Response.fromStream);
        return _returnResponse(response);
      }, retryIf: (e) async {
        debugPrint('Call API >> url: ${_getParsedUrl(path)} >> Error: $e');
        if (e is ExpiredTokenException) {
          if (numberAttempts == 3) {
            Injection().authorization = null;
            return false;
          }
          if (_authorization == null) {
            _authorization = Injection().authorization;
            if (_authorization?.accessToken == null) {
              return false;
            }

            final token = _authorization!.accessToken;
            request.headers['Authorization'] = 'Bearer $token';
            if (method == 'POST' || method == 'PATCH') {
              request.headers['content-type'] = 'application/json';
              request.body = jsonEncode(data);
            }
            request = asT<Request>(_copyRequest(request))!;
            return true;
          } else {
            /// will enable this code when API refreshToken already.
//            final refreshToken = await _refreshToken();
            _authorization = Injection().authorization;
            final token = _authorization?.accessToken;
            if (token != null) {
              request.headers['Authorization'] = 'Bearer $token';
              if (method == 'POST' || method == 'PATCH') {
                request.headers['content-type'] = 'application/json';
                request.body = jsonEncode(data);
              }
            }
            request = asT<Request>(_copyRequest(request))!;
            numberAttempts += 1;

            return true;

            /// will enable this code when API refreshToken already.
//            return refreshToken;
          }
        }

        return false;
      });
    } on SocketException {
      debugPrint('No Internet connection');
      throw const SocketException('Operation timed out');
    }
    debugPrint('''Call API >>
     $method >> url: ${_getParsedUrl(path)} >> response: $responseJson''');

    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    debugPrint('HTTP response\n'
        'Status: ${response.statusCode}\n'
        'Request: ${response.request}\n'
        'Data: ${response.body}');

    switch (response.statusCode) {
      case 200:
        if (response.body.isNotNullAndEmpty) {
          final responseJson = jsonDecode(response.body);
          return responseJson;
        }
        return null;
      case 201:
        if (response.body.isNotNullAndEmpty) {
          final responseJson = jsonDecode(response.body);
          return responseJson;
        }
        return null;
      case 204:
        return null;
      case 400:
        final responseJson = jsonDecode(response.body);
        throw BadRequestException(responseJson);
      case 401:
        final responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson);
      case 403:
        final responseJson = jsonDecode(response.body);
        throw ForbiddenException(responseJson);
      case 404:
        final responseJson = jsonDecode(response.body);
        throw NotFoundException(responseJson);
      case 422:
        final responseJson = jsonDecode(response.body);
        throw UnProcessableEntityException(responseJson);
      case 413:
        final responseJson = jsonDecode(payloadTooLargeErrorJson);
        throw PayloadTooLargeException(responseJson);
      case 409:
        final responseJson = jsonDecode(response.body);
        throw ValidationException(responseJson);
      case 500:
        final responseJson = jsonDecode(response.body);
        throw ServerErrorException(responseJson);
      default:
        final responseJson = jsonDecode(defaultErrorJson);
        throw FetchDataException(responseJson);
    }
  }

  dynamic get(String path) async {
    return await _call('GET', path);
  }

  dynamic post(String path, [dynamic data]) async {
    return await _call('POST', path, data: data);
  }

  dynamic put(String path, [dynamic data]) async {
    return await _call('PUT', path, data: data);
  }

  dynamic delete(String path, [dynamic data]) async {
    return await _call('DELETE', path, data: data);
  }

  dynamic patch(String path, [dynamic data]) async {
    return await _call('PATCH', path, data: data);
  }
}
