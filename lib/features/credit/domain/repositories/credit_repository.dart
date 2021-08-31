import '../../../../core/error/failure.dart';
import '../entities/credit.dart';
import 'package:dartz/dartz.dart';

abstract class CreditRepository {
  Future<Either<Failure, List<Credit>>>? getCredits(int? movieID);
}
