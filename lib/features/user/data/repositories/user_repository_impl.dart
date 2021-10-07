import 'package:bwaflutix/core/network/network_info.dart';
import 'package:bwaflutix/features/user/data/datasources/user_local_data_source.dart';
import 'package:bwaflutix/features/user/data/datasources/user_remote_data_source.dart';
import 'package:bwaflutix/features/user/domain/entities/user.dart';
import 'package:bwaflutix/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource? remoteDataSource;
  final UserLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  UserRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<User?>? getUser(String? id) async {
    if ((await networkInfo?.isConnected)!) {
      try {
        final remoteUser = await remoteDataSource?.getUser(id);
        localDataSource?.cacheUser(remoteUser);

        return remoteUser;
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        final localUser = await localDataSource?.getLastUser();

        return localUser;
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
