import 'dart:convert';

import 'package:bwaflutix/core/error/exceptions.dart';
import 'package:bwaflutix/features/user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<UserModel>? getLastUser();
  Future<void>? cacheUser(UserModel? userToCache);
}

const CACHED_USER = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences? sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheUser(UserModel? userToCache) {
    final jsonMap = userToCache?.toJson();
    final jsonString = json.encode(jsonMap);

    return sharedPreferences?.setString(CACHED_USER, jsonString);
  }

  @override
  Future<UserModel>? getLastUser() {
    final jsonString = sharedPreferences?.getString(CACHED_USER);
    if (jsonString != null) {
      final response = json.decode(jsonString);
      final result = UserModel.fromJson(response);

      return Future.value(result);
    } else {
      throw CacheException();
    }
  }
}
