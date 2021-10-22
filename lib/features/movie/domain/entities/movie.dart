import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String language;

  const Movie(
      {required this.id,
      required this.title,
      required this.voteAverage,
      required this.overview,
      required this.posterPath,
      required this.backdropPath,
      required this.language});

  @override
  List<Object?> get props =>
      [id, title, voteAverage, overview, posterPath, backdropPath, language];
}
