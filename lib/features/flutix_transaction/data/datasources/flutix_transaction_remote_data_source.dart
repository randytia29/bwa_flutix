import 'package:bwaflutix/features/flutix_transaction/data/models/flutix_transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FlutixTransactionRemoteDataSource {
  Future<List<FlutixTransactionModel>>? getFlutixTransactions(String? userId);
  Future<void>? saveFlutixTransaction(
      FlutixTransactionModel? flutixTransaction);
}

class FlutixTransactionRemoteDataSourceImpl
    implements FlutixTransactionRemoteDataSource {
  final FirebaseFirestore? firebaseFirestore;

  FlutixTransactionRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<List<FlutixTransactionModel>>? getFlutixTransactions(
      String? userId) async {
    CollectionReference transactionCollection =
        firebaseFirestore!.collection('transactions');
    final snapshot = await transactionCollection.get();
    final documents =
        snapshot.docs.where((document) => document['userID'] == userId);
    final flutixTransactions =
        documents.map((e) => FlutixTransactionModel.fromJson(e)).toList();

    return flutixTransactions;
  }

  @override
  Future<void>? saveFlutixTransaction(
      FlutixTransactionModel? flutixTransaction) async {
    CollectionReference transactionCollection =
        firebaseFirestore!.collection('transactions');
    await transactionCollection.doc().set(flutixTransaction?.toJson());
  }
}
