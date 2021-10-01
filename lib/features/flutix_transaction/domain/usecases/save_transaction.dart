import 'package:bwaflutix/core/usecases/usecase.dart';
import 'package:bwaflutix/features/flutix_transaction/data/models/flutix_transaction_model.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/repositories/flutix_transaction_repository.dart';
import 'package:equatable/equatable.dart';

class SaveTransaction implements Usecase<void, Params> {
  final FlutixTransactionRepository? repository;

  SaveTransaction(this.repository);

  @override
  Future<void> call(Params params) async {
    return await repository?.saveTransaction(params.flutixTransactionModel);
  }
}

class Params extends Equatable {
  final FlutixTransactionModel? flutixTransactionModel;

  Params({this.flutixTransactionModel});

  @override
  List<Object?> get props => [flutixTransactionModel];
}
