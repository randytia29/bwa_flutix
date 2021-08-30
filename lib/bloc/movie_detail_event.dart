part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class FetchMovieDetail extends MovieDetailEvent {
  final int? movieID;

  FetchMovieDetail({this.movieID});

  @override
  List<Object?> get props => [movieID];
}
