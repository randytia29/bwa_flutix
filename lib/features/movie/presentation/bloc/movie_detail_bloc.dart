import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_details.dart';
import '../../domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetDetails? getDetails;

  MovieDetailBloc({required GetDetails? details})
      : assert(details != null),
        getDetails = details,
        super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is FetchMovieDetail) {
      yield MovieDetailLoading();
      try {
        final movie = await getDetails!(Params(movieID: event.movieID));

        yield MovieDetailLoaded(movie: movie);
      } catch (e) {
        yield MovieDetailFailToLoad(message: e.toString());
      }
    }
  }
}
