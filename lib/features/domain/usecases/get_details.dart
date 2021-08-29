import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetDetails implements Usecase<MovieDetail, Params> {
  final MovieRepository? repository;

  GetDetails(this.repository);

  @override
  Future<Either<Failure, MovieDetail>?> call(Params params) async {
    return await repository?.getDetails(params.movie);
  }
}

class Params extends Equatable {
  final Movie? movie;
  final int? movieID;

  Params({this.movie, this.movieID});

  @override
  List<Object?> get props => [movie, movieID];
}
