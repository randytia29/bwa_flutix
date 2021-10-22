import '../entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/movie_repository.dart';

class GetDetails implements Usecase<MovieDetail, Params> {
  final MovieRepository? repository;

  GetDetails(this.repository);

  @override
  Future<MovieDetail?> call(Params params) async {
    return await repository?.getDetails(params.movieID);
  }
}

class Params extends Equatable {
  final int? movieID;

  const Params({this.movieID});

  @override
  List<Object?> get props => [movieID];
}
