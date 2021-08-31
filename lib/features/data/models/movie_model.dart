import 'package:bwaflutix/features/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel(
      {required int id,
      required String title,
      required double voteAverage,
      required String overview,
      required String posterPath,
      required String backdropPath,
      required String language,
      List<String>? genres})
      : super(
            id: id,
            title: title,
            voteAverage: voteAverage,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            language: language);

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // List<String> genres = <String>[];
    // if (json['genres'] != null) {
    //   var _genres = List.from(json['genres']);
    //   if (_genres.length > 0) {
    //     genres = _genres
    //         .map<String>((e) => (e as Map<String, dynamic>)['name'])
    //         .toList();
    //   }
    // }

    // String language = '';
    // switch (json['original_language'].toString()) {
    //   case 'ja':
    //     language = 'Japanese';
    //     break;
    //   case 'id':
    //     language = 'Indonesian';
    //     break;
    //   case 'ko':
    //     language = 'Korean';
    //     break;
    //   case 'en':
    //     language = 'English';
    //     break;
    // }

    return MovieModel(
        id: json['id'],
        title: json['title'],
        voteAverage: (json['vote_average'] as num).toDouble(),
        overview: json['overview'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        language: json['original_language'],
        genres: json['genres']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'vote_average': voteAverage,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'original_language': language
    };
  }
}
