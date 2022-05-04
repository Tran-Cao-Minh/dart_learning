import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:picker/common/common.dart';
import 'package:picker/data/models/models.dart';
import 'package:picker/domain/entity/entity.dart';

class TestData<T extends Entity> {
  final Mapper<T>? _mapper;

  TestData({Mapper<T>? mapper}) : _mapper = mapper;

  Future<List<T>?> getListItems(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      final finalData = json.decode(data)['data'];
      final dataJson = List<Map<String, dynamic>>.from(finalData);
      return dataJson.map(_mapper!.parse!).toList();
    } catch (e) {
      debugPrint('Cannot parse json file: $path for error: $e');
      return <T>[];
    }
  }

  Future<T?> getItem(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      final dataJson = json.decode(data);
      return _mapper!.parse!(dataJson);
    } catch (e) {
      debugPrint('Cannot parse json file: $path for error: $e');
      return null;
    }
  }

  static Future<User> submitLogin() async {
    final testData = TestData<User>(mapper: Mapper<User>(parse: User.fromJson));

    final result = await testData.getItem('mock_data/submit_login.json');
    return asT<User>(result)!;
  }
}
