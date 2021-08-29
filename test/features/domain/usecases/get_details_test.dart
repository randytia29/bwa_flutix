import 'package:bwaflutix/features/domain/entities/movie.dart';
import 'package:bwaflutix/features/domain/entities/movie_detail.dart';
import 'package:bwaflutix/features/domain/repositories/movie_repository.dart';
import 'package:bwaflutix/features/domain/usecases/get_details.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetDetails usecase;
  MockMovieRepository? mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetDetails(mockMovieRepository);
  });

  final tMovie = Movie(
      id: 1,
      title: 'title',
      voteAverage: 5.0,
      overview: 'overview',
      posterPath: 'posterPath',
      backdropPath: 'backdropPath');
  final tMovieDetail = MovieDetail(
      Movie(
          id: 1,
          title: 'title',
          voteAverage: 5.0,
          overview: 'overview',
          posterPath: 'posterPath',
          backdropPath: 'backdropPath'),
      genres: ['genres'],
      language: 'language');

  test('should get movie detail from the repository', () async {
    when(mockMovieRepository!.getDetails(any))
        .thenAnswer((realInvocation) async => Right(tMovieDetail));

    final result = await usecase(Params(movie: tMovie));

    expect(result, Right(tMovieDetail));
    verify(mockMovieRepository!.getDetails(tMovie));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
