import '../../domain/entities/movie_detail.dart';

import '../../../../core/network/network_info.dart';

import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource? remoteDataSource;
  final MovieLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  MovieRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<MovieDetail?>? getDetails(int? movieID) async {
    if ((await networkInfo?.isConnected)!) {
      try {
        final remoteMovie = await remoteDataSource?.getDetails(movieID);
        localDataSource?.cacheMovie(remoteMovie);
        return remoteMovie;
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        final localMovie = await localDataSource?.getLastMovie();
        return localMovie;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Future<List<Movie>?>? getMovies(int? page) async {
    if ((await networkInfo?.isConnected)!) {
      try {
        final remoteMovie = await remoteDataSource?.getMovies(page);
        localDataSource?.cacheMovies(remoteMovie);
        return remoteMovie;
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        final localMovie = await localDataSource?.getLastMovies();
        return localMovie;
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
