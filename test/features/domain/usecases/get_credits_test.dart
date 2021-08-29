import 'package:bwaflutix/features/domain/entities/credit.dart';
import 'package:bwaflutix/features/domain/repositories/movie_repository.dart';
import 'package:bwaflutix/features/domain/usecases/get_credits.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetCredits usecase;
  MockMovieRepository? mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetCredits(mockMovieRepository);
  });

  final tMovieID = 1;
  final tCredits = [Credit(name: 'name', profilePath: 'profilePath')];

  test('should get list of movies from the repository', () async {
    when(mockMovieRepository!.getCredits(any))
        .thenAnswer((realInvocation) async => Right(tCredits));

    final result = await usecase(Params(movieID: tMovieID));

    expect(result, Right(tCredits));
    verify(mockMovieRepository!.getCredits(tMovieID));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
