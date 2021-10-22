import 'package:bloc/bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies? getMovies;

  MovieBloc({required GetMovies? movies})
      : assert(movies != null),
        getMovies = movies,
        super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      try {
        if (state is MovieInitial) {
          final movies = await getMovies!(const Params(page: 1));

          emit(MovieLoaded(
              movies: movies, hasReachedMax: false, currentPage: 1));
        } else if (state is MovieLoaded) {
          MovieLoaded movieLoaded = state as MovieLoaded;

          final movies =
              await getMovies!(Params(page: movieLoaded.currentPage! + 1));

          if (movies!.isEmpty) {
            emit(movieLoaded.copyWith(hasReachedMax: true));
          } else {
            emit(MovieLoaded(
                movies: movieLoaded.movies! + movies,
                hasReachedMax: movies.isEmpty ? true : false,
                currentPage: movieLoaded.currentPage! + 1));
          }
        }
      } catch (e) {
        emit(MovieFailToLoad(message: e.toString()));
      }
    });
  }
}
