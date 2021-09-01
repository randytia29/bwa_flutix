import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<MovieModel?>? getLastMovie();
  Future<void>? cacheMovie(MovieModel? movieToCache);

  Future<List<MovieModel>?>? getLastMovies();
  Future<void>? cacheMovies(List<MovieModel>? moviesToCache);
}
