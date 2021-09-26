import 'dart:convert';

import 'package:bwaflutix/features/movie/data/models/movie_detail_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../shared/shared.dart';

import '../models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>>? getMovies(int? page);
  Future<MovieDetailModel>? getDetails(int? movieID);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client? client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<MovieDetailModel>? getDetails(int? movieID) async {
    final url = Uri.https(
        baseUrl, '/3/movie/$movieID', {'api_key': apiKey, 'language': 'en-US'});

    final response = await client?.get(url);

    if (response?.statusCode == 200) {
      final data = json.decode(response!.body);

      return MovieDetailModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>>? getMovies(int? page) async {
    final url = Uri.https(baseUrl, '/3/discover/movie', {
      'api_key': apiKey,
      'language': 'en-US',
      'sort_by': 'popularity.desc',
      'include_adult': 'false',
      'include_video': 'false',
      'page': '$page'
    });

    final response = await client?.get(url);

    if (response?.statusCode == 200) {
      final data = json.decode(response!.body);

      return List.from(data['results'])
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
