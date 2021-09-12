import 'package:bwaflutix/features/movie/domain/entities/movie.dart';
import 'package:bwaflutix/features/movie/domain/repositories/movie_repository.dart';
import 'package:bwaflutix/features/movie/domain/usecases/get_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetMovies usecase;
  MockMovieRepository? mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovies(mockMovieRepository);
  });

  final tPage = 1;
  final tMovie = [
    Movie(
        id: 1,
        title: 'title',
        voteAverage: 5.0,
        overview: 'overview',
        posterPath: 'posterPath',
        backdropPath: 'backdropPath',
        language: 'language')
  ];

  test('should get list of movies from the repository', () async {
    when(mockMovieRepository!.getMovies(any))
        .thenAnswer((realInvocation) async => tMovie);

    final result = await usecase(Params(page: tPage));

    expect(result, tMovie);
    verify(mockMovieRepository!.getMovies(tPage));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
