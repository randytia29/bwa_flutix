part of 'models.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String language;
  final List<String> genres;

  Movie(
      {required this.id,
      required this.title,
      required this.voteAverage,
      required this.overview,
      required this.posterPath,
      required this.backdropPath,
      required this.language,
      this.genres = const <String>[]});

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<String> genres = <String>[];
    if (json['genres'] != null) {
      var _genres = List.from(json['genres']);
      if (_genres.length > 0) {
        genres = _genres
            .map<String>((e) => (e as Map<String, dynamic>)['name'])
            .toList();
      }
    }

    String language = '';
    switch (json['original_language'].toString()) {
      case 'ja':
        language = 'Japanese';
        break;
      case 'id':
        language = 'Indonesian';
        break;
      case 'ko':
        language = 'Korean';
        break;
      case 'en':
        language = 'English';
        break;
    }

    return Movie(
        id: json['id'],
        title: json['title'],
        voteAverage: (json['vote_average'] as num).toDouble(),
        overview: json['overview'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        language: language,
        genres: genres);
  }

  String get genresAndLanguage {
    String s = '';
    for (var genre in genres) {
      s += genre + (genre != genres.last ? ', ' : '');
    }
    return '$s - $language';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        voteAverage,
        overview,
        posterPath,
        backdropPath,
        language,
        genres
      ];
}
