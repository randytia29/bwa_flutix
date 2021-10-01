import 'package:bwaflutix/core/usecases/usecase.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/repositories/flutix_transaction_repository.dart';
import 'package:equatable/equatable.dart';

class GetTransaction implements Usecase<List<FlutixTransaction>, Params> {
  final FlutixTransactionRepository? repository;

  GetTransaction(this.repository);

  @override
  Future<List<FlutixTransaction>?> call(Params params) async {
    return await repository?.getTransactions(params.userId);
  }
}

class Params extends Equatable {
  final String? userId;

  Params({this.userId});

  @override
  List<Object?> get props => [userId];
}
