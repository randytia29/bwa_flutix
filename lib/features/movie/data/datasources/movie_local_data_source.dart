import 'dart:convert';

import 'package:bwaflutix/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<MovieModel?>? getLastMovie();
  Future<void>? cacheMovie(MovieModel? movieToCache);

  Future<List<MovieModel>?>? getLastMovies();
  Future<void>? cacheMovies(List<MovieModel>? moviesToCache);
}

const CACHED_MOVIE = 'CACHED_MOVIE';
const CACHED_MOVIE_LIST = 'CACHED_MOVIE_LIST';

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences? sharedPreferences;

  MovieLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheMovie(MovieModel? movieToCache) {
    return sharedPreferences?.setString(
        CACHED_MOVIE, json.encode(movieToCache?.toJson()));
  }

  @override
  Future<void>? cacheMovies(List<MovieModel>? moviesToCache) {
    final jsonMap = moviesToCache?.map((e) => e.toJson()).toList();
    final jsonString = json.encode(jsonMap);
    return sharedPreferences?.setString(CACHED_MOVIE_LIST, jsonString);
  }

  @override
  Future<MovieModel?>? getLastMovie() {
    final jsonString = sharedPreferences?.getString(CACHED_MOVIE);
    if (jsonString != null) {
      return Future.value(MovieModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<MovieModel>?>? getLastMovies() {
    final jsonString = sharedPreferences?.getString(CACHED_MOVIE_LIST);
    if (jsonString != null) {
      final response = json.decode(jsonString);
      final result =
          List.from(response).map((e) => MovieModel.fromJson(e)).toList();
      return Future.value(result);
    } else {
      throw CacheException();
    }
  }
}
