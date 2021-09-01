import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetDetails implements Usecase<Movie, Params> {
  final MovieRepository? repository;

  GetDetails(this.repository);

  @override
  Future<Either<Failure, Movie?>?> call(Params params) async {
    return await repository?.getDetails(params.movieID);
  }
}

class Params extends Equatable {
  final int? movieID;

  Params({this.movieID});

  @override
  List<Object?> get props => [movieID];
}
