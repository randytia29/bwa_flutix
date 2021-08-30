import '../entities/credit.dart';

import '../../../core/error/failure.dart';
import '../entities/movie.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>>? getMovies(int? page);
  Future<Either<Failure, Movie>>? getDetails(int? movieID);
  Future<Either<Failure, List<Credit>>>? getCredits(int? movieID);
}
