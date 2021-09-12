import '../../../../core/network/network_info.dart';

import '../datasources/credit_local_data_source.dart';
import '../datasources/credit_remote_data_source.dart';
import '../../domain/entities/credit.dart';
import '../../domain/repositories/credit_repository.dart';

class CreditRepositoryImpl implements CreditRepository {
  final CreditRemoteDataSource? remoteDataSource;
  final CreditLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  CreditRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<List<Credit>?>? getCredits(int? movieID) async {
    if ((await networkInfo?.isConnected)!) {
      try {
        final remoteMovie = await remoteDataSource?.getCredits(movieID);
        localDataSource?.cacheCredits(remoteMovie);
        return remoteMovie;
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        final localMovie = await localDataSource?.getLastCredits();
        return localMovie;
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
