import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel(
      {required int id,
      required String title,
      required double voteAverage,
      required String overview,
      required String posterPath,
      required String backdropPath,
      required String language})
      : super(
            id: id,
            title: title,
            voteAverage: voteAverage,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            language: language);

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
