import 'dart:async';

import 'package:bloc/bloc.dart';
import '../models/models.dart';
import '../services/services.dart';
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
      if (state is MovieInitial) {
        List<Movie> movies = await MovieServices.getMovies(1);

        yield MovieLoaded(movies: movies, hasReachedMax: false, currentPage: 1);
      } else if (state is MovieLoaded) {
        MovieLoaded movieLoaded = state as MovieLoaded;
        List<Movie> movies =
            await MovieServices.getMovies(movieLoaded.currentPage! + 1);

        yield (movies.isEmpty)
            ? movieLoaded.copyWith(hasReachedMax: true)
            : MovieLoaded(
                movies: movieLoaded.movies! + movies,
                hasReachedMax: movies.isEmpty ? true : false,
                currentPage: movieLoaded.currentPage! + 1);
      }
    }
  }
}
