import '../../../../core/usecases/usecase.dart';
import '../repositories/credit_repository.dart';

import '../entities/credit.dart';
import 'package:equatable/equatable.dart';

class GetCredits implements Usecase<List<Credit>, Params> {
  final CreditRepository? repository;

  GetCredits(this.repository);

  @override
  Future<List<Credit>?> call(Params params) async {
    return await repository?.getCredits(params.movieID);
  }
}

class Params extends Equatable {
  final int? movieID;

  Params({this.movieID});

  @override
  List<Object?> get props => [movieID];
}
