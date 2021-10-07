import '../../domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  MovieDetailModel(
      {required int id,
      required String title,
      required double voteAverage,
      required String overview,
      required String posterPath,
      required String backdropPath,
      required String language,
      required List<String> genres})
      : super(
            id: id,
            title: title,
            voteAverage: voteAverage,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            language: language,
            genres: genres);

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
