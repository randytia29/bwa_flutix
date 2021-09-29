import '../entities/movie_detail.dart';

import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>?>? getMovies(int? page);
  Future<MovieDetail?>? getDetails(int? movieID);
}
