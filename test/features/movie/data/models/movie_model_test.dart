import 'dart:convert';

import 'package:bwaflutix/features/movie/data/models/movie_model.dart';
import 'package:bwaflutix/features/movie/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tMovieModel = MovieModel(
      id: 436969,
      title: 'The Suicide Squad',
      voteAverage: 8,
      overview:
          'Supervillains Harley Quinn, Bloodsport, Peacemaker and a collection of nutty cons at Belle Reve prison join the super-secret, super-shady Task Force X as they are dropped off at the remote, enemy-infused island of Corto Maltese.',
      posterPath: '/iXbWpCkIauBMStSTUT9v4GXvdgH.jpg',
      backdropPath: '/jlGmlFOcfo8n5tURmhC7YVd4Iyy.jpg',
      language: 'en');

  test('should be subclass of Movie Entity', () async {
    expect(tMovieModel, isA<Movie>());
  });

  group('fromJson', () {
    test('should return a valid movie model', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('movie.json'));

      final result = MovieModel.fromJson(jsonMap);

      expect(result, tMovieModel);
    });
  });

  group('toJson', () {
    test('should return a JSON Movie map', () async {
      final result = tMovieModel.toJson();

      final expectedMap = {
        'id': 436969,
        'title': 'The Suicide Squad',
        'vote_average': 8,
        'overview':
            'Supervillains Harley Quinn, Bloodsport, Peacemaker and a collection of nutty cons at Belle Reve prison join the super-secret, super-shady Task Force X as they are dropped off at the remote, enemy-infused island of Corto Maltese.',
        'poster_path': '/iXbWpCkIauBMStSTUT9v4GXvdgH.jpg',
        'backdrop_path': '/jlGmlFOcfo8n5tURmhC7YVd4Iyy.jpg',
        'original_language': 'en'
      };
      expect(result, expectedMap);
    });
  });
}
