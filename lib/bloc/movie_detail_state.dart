part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object?> get props => [];
}

class MovieDetailLoading extends MovieDetailState {
  @override
  List<Object?> get props => [];
}

class MovieDetailLoaded extends MovieDetailState {
  final Movie? movie;
  final List<Credit>? credits;

  MovieDetailLoaded(this.movie, this.credits);

  @override
  List<Object?> get props => [movie, credits];
}
