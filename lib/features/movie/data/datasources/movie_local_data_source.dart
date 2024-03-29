import 'dart:convert';

import '../models/movie_detail_model.dart';

import '../../../../core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<MovieDetailModel>? getLastMovie();
  Future<void>? cacheMovie(MovieDetailModel? movieToCache);

  Future<List<MovieModel>>? getLastMovies();
  Future<void>? cacheMovies(List<MovieModel>? moviesToCache);
}

const cachedMovie = 'CACHED_MOVIE';
const cachedMovieList = 'CACHED_MOVIE_LIST';

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences? sharedPreferences;

  MovieLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheMovie(MovieDetailModel? movieToCache) {
    return sharedPreferences?.setString(
        cachedMovie, json.encode(movieToCache?.toJson()));
  }

  @override
  Future<void>? cacheMovies(List<MovieModel>? moviesToCache) {
    final jsonMap = moviesToCache?.map((e) => e.toJson()).toList();
    final jsonString = json.encode(jsonMap);

    return sharedPreferences?.setString(cachedMovieList, jsonString);
  }

  @override
  Future<MovieDetailModel>? getLastMovie() {
    final jsonString = sharedPreferences?.getString(cachedMovie);
    if (jsonString != null) {
      return Future.value(MovieDetailModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<MovieModel>>? getLastMovies() {
    final jsonString = sharedPreferences?.getString(cachedMovieList);
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
