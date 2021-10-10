import 'package:bwaflutix/core/error/exceptions.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';
import 'package:hive/hive.dart';

abstract class FlutixTransactionLocalDataSource {
  Future<List<FlutixTransaction>>? getLastFlutixTransactions();
  Future<void>? cacheFlutixTransaction(
      List<FlutixTransaction>? flutixTransactionToCache);
}

const CACHED_FLUTIX_TRANSACTION_LIST = 'CACHED_FLUTIX_TRANSACTION_LIST';

const FLUTIX_TRANSACTION_BOX = 'FLUTIX_TRANSACTION_BOX';

class FlutixTransactionLocalDataSourceImpl
    implements FlutixTransactionLocalDataSource {
  final HiveInterface? hive;

  FlutixTransactionLocalDataSourceImpl({required this.hive});

  @override
  Future<void>? cacheFlutixTransaction(
      List<FlutixTransaction>? flutixTransactionToCache) async {
    final flutixTransactionBox = await hive?.openBox(FLUTIX_TRANSACTION_BOX);

    flutixTransactionBox?.deleteAll(flutixTransactionBox.keys);
    flutixTransactionBox?.addAll(flutixTransactionToCache!.map((e) => e));

    flutixTransactionBox?.close();
  }

  @override
  Future<List<FlutixTransaction>>? getLastFlutixTransactions() async {
    final flutixTransactionBox = await hive?.openBox(FLUTIX_TRANSACTION_BOX);

    if (flutixTransactionBox!.isNotEmpty) {
      final result =
          flutixTransactionBox.values.map<FlutixTransaction>((e) => e).toList();
      await flutixTransactionBox.close();

      return Future.value(result);
    } else {
      throw CacheException();
    }
  }
}
