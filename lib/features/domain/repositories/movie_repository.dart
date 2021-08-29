import '../entities/credit.dart';
import '../entities/movie_detail.dart';

import '../../../core/error/failure.dart';
import '../entities/movie.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>>? getMovies(int? page);
  Future<Either<Failure, MovieDetail>>? getDetails(Movie? movie,
      {int? movieID});
  Future<Either<Failure, List<Credit>>>? getCredits(int? movieID);
}
