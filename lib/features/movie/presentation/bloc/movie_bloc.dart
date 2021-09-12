import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_movies.dart';
import '../../domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies? getMovies;

  MovieBloc({required GetMovies? movies})
      : assert(movies != null),
        getMovies = movies,
        super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMovies) {
      try {
        if (state is MovieInitial) {
          final movies = await getMovies!(Params(page: 1));

          yield MovieLoaded(
              movies: movies, hasReachedMax: false, currentPage: 1);
        } else if (state is MovieLoaded) {
          MovieLoaded movieLoaded = state as MovieLoaded;

          final movies =
              await getMovies!(Params(page: movieLoaded.currentPage! + 1));

          if (movies!.isEmpty) {
            yield movieLoaded.copyWith(hasReachedMax: true);
          } else {
            yield MovieLoaded(
                movies: movieLoaded.movies! + movies,
                hasReachedMax: movies.isEmpty ? true : false,
                currentPage: movieLoaded.currentPage! + 1);
          }
        }
      } catch (e) {
        yield MovieFailToLoad(message: e.toString());
      }
    }
  }
}
