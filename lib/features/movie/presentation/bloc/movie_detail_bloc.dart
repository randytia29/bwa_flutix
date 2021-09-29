import 'package:bloc/bloc.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_details.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetDetails? getDetails;

  MovieDetailBloc({required GetDetails? details})
      : assert(details != null),
        getDetails = details,
        super(MovieDetailInitial()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final movie = await getDetails!(Params(movieID: event.movieID));

        emit(MovieDetailLoaded(movie: movie));
      } catch (e) {
        emit(MovieDetailFailToLoad(message: e.toString()));
      }
    });
  }
}
