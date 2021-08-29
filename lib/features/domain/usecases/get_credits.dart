import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/credit.dart';
import '../repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCredits implements Usecase<List<Credit>, Params> {
  final MovieRepository? repository;

  GetCredits(this.repository);

  @override
  Future<Either<Failure, List<Credit>>?> call(Params params) async {
    return await repository?.getCredits(params.movieID);
  }
}

class Params extends Equatable {
  final int? movieID;

  Params({this.movieID});

  @override
  List<Object?> get props => [];
}
