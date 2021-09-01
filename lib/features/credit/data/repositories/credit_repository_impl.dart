import '../../../../core/error/exceptions.dart';

import '../../../../core/platform/network_info.dart';
import '../datasources/credit_local_data_source.dart';
import '../datasources/credit_remote_data_source.dart';
import '../../domain/entities/credit.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/credit_repository.dart';
import 'package:dartz/dartz.dart';

class CreditRepositoryImpl implements CreditRepository {
  final CreditRemoteDataSource? remoteDataSource;
  final CreditLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  CreditRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Credit>?>>? getCredits(int? movieID) async {
    if ((await networkInfo?.isConnected)!) {
      try {
        final remoteMovie = await remoteDataSource?.getCredits(movieID);
        localDataSource?.cacheCredits(remoteMovie);
        return Right(remoteMovie);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localMovie = await localDataSource?.getLastCredits();
        return Right(localMovie);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
