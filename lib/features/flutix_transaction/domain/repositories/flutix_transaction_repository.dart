import 'package:bwaflutix/features/flutix_transaction/data/models/flutix_transaction_model.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';

abstract class FlutixTransactionRepository {
  Future<void>? saveTransaction(FlutixTransactionModel? flutixTransaction);
  Future<List<FlutixTransaction>?>? getTransactions(String? userId);
}
