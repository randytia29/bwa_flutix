import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>?>? getMovies(int? page);
  Future<Movie?>? getDetails(int? movieID);
}
