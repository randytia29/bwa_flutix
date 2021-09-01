import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>?>? getMovies(int? page);
  Future<MovieModel?>? getDetails(int? movieID);
}
