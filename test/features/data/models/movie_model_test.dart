import 'dart:convert';

import 'package:bwaflutix/features/data/models/movie_model.dart';
import 'package:bwaflutix/features/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tMovieModel = MovieModel(
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
}
