import 'dart:convert';

import 'package:bwaflutix/core/error/exceptions.dart';
import 'package:bwaflutix/features/movie/data/datasources/movie_local_data_source.dart';
import 'package:bwaflutix/features/movie/data/models/movie_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MovieLocalDataSourceImpl? dataSource;
  MockSharedPreferences? mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        MovieLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastMovie', () {
    final tMovieModel = MovieModel.fromJson(json.decode(fixture('movie.json')));

    test(
        'should return Movie from SharedPreferences when there is on in the cache',
        () async {
      when(mockSharedPreferences?.getString(cachedMovie))
          .thenReturn(fixture('movie.json'));

      final result = await dataSource?.getLastMovie();

      verify(mockSharedPreferences?.getString(cachedMovie));
      expect(result, equals(tMovieModel));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      when(mockSharedPreferences?.getString(cachedMovie)).thenReturn(null);

      expect(() => dataSource?.getLastMovie(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('getLastMovieList', () {
    final tMovieModelList = List.from(json.decode(fixture('movie_list.json')))
        .map((e) => MovieModel.fromJson(e))
        .toList();

    test(
        'should return MovieList from SharedPreferences when there is on in the cache',
        () async {
      when(mockSharedPreferences?.getString(cachedMovieList))
          .thenReturn(fixture('movie_list.json'));

      final result = await dataSource?.getLastMovies();

      verify(mockSharedPreferences?.getString(cachedMovieList));
      expect(result, equals(tMovieModelList));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      when(mockSharedPreferences?.getString(cachedMovieList)).thenReturn(null);

      expect(() => dataSource?.getLastMovies(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  // group('cacheMovie', () {
  //   final MovieModel? tMovieModel = MovieModel(
  //       id: 436969,
  //       title: 'The Suicide Squad',
  //       voteAverage: 8,
  //       overview:
  //           'Supervillains Harley Quinn, Bloodsport, Peacemaker and a collection of nutty cons at Belle Reve prison join the super-secret, super-shady Task Force X as they are dropped off at the remote, enemy-infused island of Corto Maltese.',
  //       posterPath: '/iXbWpCkIauBMStSTUT9v4GXvdgH.jpg',
  //       backdropPath: '/jlGmlFOcfo8n5tURmhC7YVd4Iyy.jpg',
  //       language: 'en');
  //   test('should call SharedPreferences to cache the data', () async {
  //     dataSource?.cacheMovie(tMovieModel);

  //     final expectedJsonString = json.encode(tMovieModel?.toJson());
  //     verify(
  //         mockSharedPreferences?.setString(CACHED_MOVIE, expectedJsonString));
  //   });
  // });
}
