import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel(
      {required super.id,
      required super.title,
      required super.voteAverage,
      required super.overview,
      required super.posterPath,
      required super.backdropPath,
      required super.language});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'],
        title: json['title'],
        voteAverage: (json['vote_average'] as num).toDouble(),
        overview: json['overview'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        language: json['original_language']);
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
