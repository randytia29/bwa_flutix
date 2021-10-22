import 'package:bwaflutix/features/movie/domain/entities/movie_detail.dart';
import 'package:bwaflutix/features/movie/domain/repositories/movie_repository.dart';
import 'package:bwaflutix/features/movie/domain/usecases/get_details.dart';
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

  const tMovieID = 1;
  const tMovie = MovieDetail(
    id: 1,
    title: 'title',
    voteAverage: 5.0,
    overview: 'overview',
    posterPath: 'posterPath',
    backdropPath: 'backdropPath',
    language: 'language',
    genres: ['Comedy', 'Crime'],
  );

  test('should get movie detail from the repository', () async {
    when(mockMovieRepository!.getDetails(any))
        .thenAnswer((realInvocation) async => tMovie);

    final result = await usecase(const Params(movieID: tMovieID));

    expect(result, tMovie);
    verify(mockMovieRepository!.getDetails(tMovieID));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
