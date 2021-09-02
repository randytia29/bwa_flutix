import '../../../../core/network/network_info.dart';

import '../../../../core/error/exceptions.dart';

import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';
import '../../domain/entities/movie.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource? remoteDataSource;
  final MovieLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  MovieRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Movie?>>? getDetails(int? movieID) async {
    if ((await networkInfo?.isConnected)!) {
      try {
        final remoteMovie = await remoteDataSource?.getDetails(movieID);
        localDataSource?.cacheMovie(remoteMovie);
        return Right(remoteMovie);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localMovie = await localDataSource?.getLastMovie();
        return Right(localMovie);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>?>>? getMovies(int? page) async {
    if ((await networkInfo?.isConnected)!) {
      try {
        final remoteMovie = await remoteDataSource?.getMovies(page);
        localDataSource?.cacheMovies(remoteMovie);
        return Right(remoteMovie);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localMovie = await localDataSource?.getLastMovies();
        return Right(localMovie);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
