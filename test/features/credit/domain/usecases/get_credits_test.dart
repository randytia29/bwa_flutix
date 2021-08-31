import 'package:bwaflutix/features/credit/domain/entities/credit.dart';
import 'package:bwaflutix/features/credit/domain/repositories/credit_repository.dart';
import 'package:bwaflutix/features/credit/domain/usecases/get_credits.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCreditRepository extends Mock implements CreditRepository {}

void main() {
  late GetCredits usecase;
  MockCreditRepository? mockCreditRepository;

  setUp(() {
    mockCreditRepository = MockCreditRepository();
    usecase = GetCredits(mockCreditRepository);
  });

  final tMovieID = 1;
  final tCredits = [Credit(name: 'name', profilePath: 'profilePath')];

  test('should get list of credits from the repository', () async {
    when(mockCreditRepository!.getCredits(any))
        .thenAnswer((realInvocation) async => Right(tCredits));

    final result = await usecase(Params(movieID: tMovieID));

    expect(result, Right(tCredits));
    verify(mockCreditRepository!.getCredits(tMovieID));
    verifyNoMoreInteractions(mockCreditRepository);
  });
}
