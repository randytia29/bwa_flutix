part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoaded extends MovieState {
  final List<Movie>? movies;
  final bool? hasReachedMax;
  final int? currentPage;

  MovieLoaded(
      {required this.movies,
      required this.hasReachedMax,
      this.currentPage = 1});

  MovieLoaded copyWith(
      {List<Movie>? movies, bool? hasReachedMax, int? currentPage}) {
    return MovieLoaded(
        movies: movies ?? this.movies,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object?> get props => [movies, hasReachedMax, currentPage];
}
