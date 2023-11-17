import '../../domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel(
      {required super.id,
      required super.title,
      required super.voteAverage,
      required super.overview,
      required super.posterPath,
      required super.backdropPath,
      required super.language,
      required super.genres});

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
        id: json['id'],
        title: json['title'],
        voteAverage: (json['vote_average'] as num).toDouble(),
        overview: json['overview'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        language: json['original_language'],
        genres: (json['genres'] as List)
            .map((e) => (e as Map<String, dynamic>)['name'].toString())
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'vote_average': voteAverage,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'original_language': language,
      'genres': genres
    };
  }
}
