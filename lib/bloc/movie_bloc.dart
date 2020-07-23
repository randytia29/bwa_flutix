import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwaflutix/models/models.dart';
import 'package:bwaflutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMovies) {
      List<Movie> movies = await MovieServices.getMovies(1);
      yield MovieLoaded(movies: movies);
    }
  }
}
