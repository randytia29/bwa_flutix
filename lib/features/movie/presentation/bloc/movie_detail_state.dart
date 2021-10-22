part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail? movie;

  const MovieDetailLoaded({required this.movie});
}

class MovieDetailFailToLoad extends MovieDetailState {
  final String message;

  const MovieDetailFailToLoad({required this.message});
}
