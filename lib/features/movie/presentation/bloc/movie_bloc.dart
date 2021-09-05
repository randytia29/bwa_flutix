import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
