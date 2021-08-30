import 'package:equatable/equatable.dart';

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

  // String get genresAndLanguage {
  //   String s = '';
  //   for (var genre in genres) {
  //     s += genre + (genre != genres.last ? ', ' : '');
  //   }
  //   return '$s - $language';
  // }

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
