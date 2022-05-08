import 'dart:developer';

import 'package:bwaflutix/core/network/network_info.dart';
import 'package:bwaflutix/features/flutix_transaction/data/datasources/flutix_transaction_local_data_source.dart';
import 'package:bwaflutix/features/flutix_transaction/data/datasources/flutix_transaction_remote_data_source.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';
import 'package:bwaflutix/features/flutix_transaction/data/models/flutix_transaction_model.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/repositories/flutix_transaction_repository.dart';

class FlutixTransactionRepositoryImpl implements FlutixTransactionRepository {
  final FlutixTransactionRemoteDataSource? remoteDataSource;
  final FlutixTransactionLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  FlutixTransactionRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<List<FlutixTransaction>?>? getTransactions(String? userId) async {
    if ((await networkInfo?.isConnected)!) {
      try {
        final remoteFlutixTransaction =
            await remoteDataSource?.getFlutixTransactions(userId);
        localDataSource?.cacheFlutixTransaction(remoteFlutixTransaction);

        return remoteFlutixTransaction;
      } catch (e) {
        log(e.toString());
        return null;
      }
    } else {
      try {
        final localFlutixTransaction =
            await localDataSource?.getLastFlutixTransactions();

        return localFlutixTransaction;
      } catch (e) {
        log(e.toString());
        return null;
      }
    }
  }

  @override
  Future<void>? saveTransaction(
      FlutixTransactionModel? flutixTransaction) async {
    await remoteDataSource?.saveFlutixTransaction(flutixTransaction);
  }
}
