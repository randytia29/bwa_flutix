import 'dart:convert';

import 'package:bwaflutix/core/error/exceptions.dart';
import 'package:bwaflutix/features/flutix_transaction/data/models/flutix_transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FlutixTransactionLocalDataSource {
  Future<List<FlutixTransactionModel>>? getLastFlutixTransactions();
  Future<void>? cacheFlutixTransaction(
      List<FlutixTransactionModel>? flutixTransactionToCache);
}

const CACHED_FLUTIX_TRANSACTION_LIST = 'CACHED_FLUTIX_TRANSACTION_LIST';

class FlutixTransactionLocalDataSourceImpl
    implements FlutixTransactionLocalDataSource {
  final SharedPreferences? sharedPreferences;

  FlutixTransactionLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheFlutixTransaction(
      List<FlutixTransactionModel>? flutixTransactionToCache) {
    final jsonMap = flutixTransactionToCache?.map((e) => e.toJson()).toList();
    final jsonString = json.encode(jsonMap);

    return sharedPreferences?.setString(
        CACHED_FLUTIX_TRANSACTION_LIST, jsonString);
  }

  @override
  Future<List<FlutixTransactionModel>>? getLastFlutixTransactions() {
    final jsonString =
        sharedPreferences?.getString(CACHED_FLUTIX_TRANSACTION_LIST);
    if (jsonString != null) {
      final response = json.decode(jsonString);
      final result = List.from(response)
          .map((e) => FlutixTransactionModel.fromJson(e))
          .toList();

      return Future.value(result);
    } else {
      throw CacheException();
    }
  }
}
