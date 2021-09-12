import 'package:bwaflutix/core/network/network_info.dart';
import 'package:bwaflutix/features/credit/data/datasources/credit_local_data_source.dart';
import 'package:bwaflutix/features/credit/data/datasources/credit_remote_data_source.dart';
import 'package:bwaflutix/features/credit/data/models/credit_model.dart';
import 'package:bwaflutix/features/credit/data/repositories/credit_repository_impl.dart';
import 'package:bwaflutix/features/credit/domain/entities/credit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements CreditRemoteDataSource {}

class MockLocalDataSource extends Mock implements CreditLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  CreditRepositoryImpl? repository;
  MockRemoteDataSource? mockRemoteDataSource;
  MockLocalDataSource? mockLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CreditRepositoryImpl(
        remoteDataSource: mockRemoteDataSource!,
        localDataSource: mockLocalDataSource!,
        networkInfo: mockNetworkInfo!);
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo?.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo?.isConnected)
            .thenAnswer((realInvocation) async => false);
      });

      body();
    });
  }

  group('getCredits', () {
    final tMovieID = 1;
    final tCreditModel = [
      CreditModel(
          name: 'Kostja Ullmann',
          profilePath: '/mQguH03eznJhsfwpZJZrnWCs5Su.jpg')
    ];
    final List<Credit> tCredits = tCreditModel;

    test('should check if the device is online', () async {
      when(mockNetworkInfo?.isConnected)
          .thenAnswer((realInvocation) async => true);

      repository?.getCredits(tMovieID);

      verify(mockNetworkInfo?.isConnected);
    });

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource?.getCredits(any))
            .thenAnswer((realInvocation) async => tCreditModel);

        final result = await repository?.getCredits(tMovieID);

        verify(mockRemoteDataSource?.getCredits(tMovieID));
        expect(result, equals(tCredits));
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource?.getCredits(any))
            .thenAnswer((realInvocation) async => tCreditModel);

        await repository?.getCredits(tMovieID);

        verify(mockRemoteDataSource?.getCredits(tMovieID));
        verify(mockLocalDataSource?.cacheCredits(tCreditModel));
      });

      runTestOffline(() {
        test(
            'should return locally cached data when the cached data is present',
            () async {
          when(mockLocalDataSource?.getLastCredits())
              .thenAnswer((realInvocation) async => tCreditModel);

          final result = await repository?.getCredits(tMovieID);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource?.getLastCredits());
          expect(result, equals(tCredits));
        });
      });
    });
  });
}
