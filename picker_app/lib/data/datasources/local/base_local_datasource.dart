import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:picker/data/models/models.dart';
import 'package:picker/domain/entity/entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseLocalDataSource<T extends Entity> {
  final Mapper<T>? _mapper;
  final SharedPreferences prefs;
  int lastUpdatedTime = 0;

  BaseLocalDataSource({
    required Mapper<T> mapper,
    required this.prefs,
  }) : _mapper = mapper;

  Future<void> saveItem(T item, String key) async {
    await prefs.setString(key, json.encode(item.toJson()));
  }

  T? getItem(String key) {
    if (_mapper == null) {
      return null;
    }

    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final dic = Map<String, dynamic>.from(json.decode(jsonString));
      if (dic.isEmpty) {
        return null;
      }

      if (_mapper!.parse != null) {
        return _mapper!.parse!(dic);
      }

      return null;
    }

    return null;
  }

  Future<void> clearObjectOrEntity(String key) async {
    await prefs.remove(key);
  }

  Future<void> saveEntity<S extends Entity>(
      S entity,
      String key,
      ) async {
    try {
      await prefs.setString(key, json.encode(entity.toJson()));
    } catch (e) {
      debugPrint('error-saveEntity: $e');
    }
  }

  S? getEntity<S extends Entity>(
      String key, {
        required Mapper<S>? mapper,
      }) {
    if (mapper == null) {
      return null;
    }

    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final dic = Map<String, dynamic>.from(json.decode(jsonString));
      if (dic.isEmpty) {
        return null;
      }

      if (mapper.parse != null) {
        return mapper.parse!(dic);
      }

      return null;
    }

    return null;
  }

  Future<void> saveString(String value, String key) async {
    await prefs.setString(key, value);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future<void> saveInteger(int value, String key) async {
    await prefs.setInt(key, value);
  }

  int? getInteger(String key) {
    return prefs.getInt(key);
  }

  Future<void> saveBoolean(bool value, String key) async {
    await prefs.setBool(key, value);
  }

  bool? getBoolean(String key) {
    return prefs.getBool(key);
  }

  @override
  String toString() {
    return 'BaseDao';
  }

  String get _lastUpdatedKey => 'key_${toString()}_last_update';

  int lastUpdated() {
    if (lastUpdatedTime > 0) {
      return lastUpdatedTime;
    }

    final updatedTime = prefs.getInt(_lastUpdatedKey);
    if (updatedTime != null) {
      lastUpdatedTime = updatedTime;
    }

    return lastUpdatedTime;
  }
}
