import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/credit_model.dart';

abstract class CreditLocalDataSource {
  Future<List<CreditModel>>? getLastCredits();
  Future<void>? cacheCredits(List<CreditModel>? creditToCache);
}

const cachedCreditList = 'CACHED_CREDIT_LIST';

class CreditLocalDataSourceImpl implements CreditLocalDataSource {
  final SharedPreferences? sharedPreferences;

  CreditLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheCredits(List<CreditModel>? creditToCache) {
    final jsonMap = creditToCache?.map((e) => e.toJson()).toList();
    final jsonString = json.encode(jsonMap);
    return sharedPreferences?.setString(cachedCreditList, jsonString);
  }

  @override
  Future<List<CreditModel>>? getLastCredits() {
    final jsonString = sharedPreferences?.getString(cachedCreditList);
    if (jsonString != null) {
      final response = json.decode(jsonString);
      final result =
          List.from(response).map((e) => CreditModel.fromJson(e)).toList();
      return Future.value(result);
    } else {
      throw CacheException();
    }
  }
}
