import 'dart:async';

import 'package:bloc/bloc.dart';
import '../models/models.dart';
import '../services/services.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is FetchMovieDetail) {
      yield MovieDetailLoading();

      final movie = await MovieServices.getDetails(event.movieID);
      final credits = await MovieServices.getCredits(event.movieID);
      credits.removeWhere((element) => element.profilePath == null);

      yield MovieDetailLoaded(movie, credits);
    }
  }
}
