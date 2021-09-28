import '../../../../core/usecases/usecase.dart';

import 'package:equatable/equatable.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMovies implements Usecase<List<Movie>, Params> {
  final MovieRepository? repository;

  GetMovies(this.repository);

  @override
  Future<List<Movie>?> call(Params params) async {
    return await repository?.getMovies(params.page);
  }
}

class Params extends Equatable {
  final int? page;

  Params({this.page});

  @override
  List<Object?> get props => [page];
}
