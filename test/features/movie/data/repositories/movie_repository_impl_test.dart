import 'package:bwaflutix/core/error/exceptions.dart';
import 'package:bwaflutix/core/error/failure.dart';
import 'package:bwaflutix/core/network/network_info.dart';
import 'package:bwaflutix/features/movie/data/datasources/movie_local_data_source.dart';
import 'package:bwaflutix/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:bwaflutix/features/movie/data/models/movie_model.dart';
import 'package:bwaflutix/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:bwaflutix/features/movie/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements MovieRemoteDataSource {}

class MockLocalDataSource extends Mock implements MovieLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MovieRepositoryImpl? repository;
  MockRemoteDataSource? mockRemoteDataSource;
  MockLocalDataSource? mockLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImpl(
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

  group('getDetails', () {
    final tMovieID = 1;
    final tMovieModel = MovieModel(
        id: 436969,
        title: 'The Suicide Squad',
        voteAverage: 8,
        overview:
            'Supervillains Harley Quinn, Bloodsport, Peacemaker and a collection of nutty cons at Belle Reve prison join the super-secret, super-shady Task Force X as they are dropped off at the remote, enemy-infused island of Corto Maltese.',
        posterPath: '/iXbWpCkIauBMStSTUT9v4GXvdgH.jpg',
        backdropPath: '/jlGmlFOcfo8n5tURmhC7YVd4Iyy.jpg',
        language: 'en');
    final Movie tMovie = tMovieModel;

    test('should check if the device is online', () async {
      when(mockNetworkInfo?.isConnected)
          .thenAnswer((realInvocation) async => true);

      repository?.getDetails(tMovieID);

      verify(mockNetworkInfo?.isConnected);
    });

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource?.getDetails(any))
            .thenAnswer((realInvocation) async => tMovieModel);

        final result = await repository?.getDetails(tMovieID);

        verify(mockRemoteDataSource?.getDetails(tMovieID));
        expect(result, equals(Right(tMovie)));
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource?.getDetails(any))
            .thenAnswer((realInvocation) async => tMovieModel);

        await repository?.getDetails(tMovieID);

        verify(mockRemoteDataSource?.getDetails(tMovieID));
        verify(mockLocalDataSource?.cacheMovie(tMovieModel));
      });

      test(
          'should return server failur when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource?.getDetails(any))
            .thenThrow(ServerException());

        final result = await repository?.getDetails(tMovieID);

        verify(mockRemoteDataSource?.getDetails(tMovieID));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });

      runTestOffline(() {
        test(
            'should return locally cached data when the cached data is present',
            () async {
          when(mockLocalDataSource?.getLastMovie())
              .thenAnswer((realInvocation) async => tMovieModel);

          final result = await repository?.getDetails(tMovieID);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource?.getLastMovie());
          expect(result, equals(Right(tMovie)));
        });

        test('should return CacheFailure when there is no cached data present',
            () async {
          when(mockLocalDataSource?.getLastMovie()).thenThrow(CacheException());

          final result = await repository?.getDetails(tMovieID);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource?.getLastMovie());
          expect(result, equals(Left(CacheFailure())));
        });
      });
    });
  });

  group('getMovies', () {
    final tPage = 1;
    final tMovieModel = [
      MovieModel(
          id: 436969,
          title: 'The Suicide Squad',
          voteAverage: 8,
          overview:
              'Supervillains Harley Quinn, Bloodsport, Peacemaker and a collection of nutty cons at Belle Reve prison join the super-secret, super-shady Task Force X as they are dropped off at the remote, enemy-infused island of Corto Maltese.',
          posterPath: '/iXbWpCkIauBMStSTUT9v4GXvdgH.jpg',
          backdropPath: '/jlGmlFOcfo8n5tURmhC7YVd4Iyy.jpg',
          language: 'en')
    ];
    final List<Movie> tMovie = tMovieModel;

    test('should check if the device is online', () async {
      when(mockNetworkInfo?.isConnected)
          .thenAnswer((realInvocation) async => true);

      repository?.getMovies(tPage);

      verify(mockNetworkInfo?.isConnected);
    });

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource?.getMovies(any))
            .thenAnswer((realInvocation) async => tMovieModel);

        final result = await repository?.getMovies(tPage);

        verify(mockRemoteDataSource?.getMovies(tPage));
        expect(result, equals(Right(tMovie)));
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource?.getMovies(any))
            .thenAnswer((realInvocation) async => tMovieModel);

        await repository?.getMovies(tPage);

        verify(mockRemoteDataSource?.getMovies(tPage));
        verify(mockLocalDataSource?.cacheMovies(tMovieModel));
      });

      test(
          'should return server failur when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource?.getMovies(any)).thenThrow(ServerException());

        final result = await repository?.getMovies(tPage);

        verify(mockRemoteDataSource?.getMovies(tPage));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });

      runTestOffline(() {
        test(
            'should return locally cached data when the cached data is present',
            () async {
          when(mockLocalDataSource?.getLastMovies())
              .thenAnswer((realInvocation) async => tMovieModel);

          final result = await repository?.getMovies(tPage);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource?.getLastMovies());
          expect(result, equals(Right(tMovie)));
        });

        test('should return CacheFailure when there is no cached data present',
            () async {
          when(mockLocalDataSource?.getLastMovies())
              .thenThrow(CacheException());

          final result = await repository?.getMovies(tPage);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource?.getLastMovies());
          expect(result, equals(Left(CacheFailure())));
        });
      });
    });
  });
}