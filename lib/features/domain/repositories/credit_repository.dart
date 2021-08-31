import 'package:bwaflutix/core/error/failure.dart';
import 'package:bwaflutix/features/domain/entities/credit.dart';
import 'package:dartz/dartz.dart';

abstract class CreditRepository {
  Future<Either<Failure, List<Credit>>>? getCredits(int? movieID);
}
