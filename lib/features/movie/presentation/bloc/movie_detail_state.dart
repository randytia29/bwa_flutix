part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Movie? movie;

  MovieDetailLoaded({required this.movie});
}

class MovieDetailFailToLoad extends MovieDetailState {
  final String message;

  MovieDetailFailToLoad({required this.message});
}
