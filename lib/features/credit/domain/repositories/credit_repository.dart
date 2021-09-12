import '../entities/credit.dart';

abstract class CreditRepository {
  Future<List<Credit>?>? getCredits(int? movieID);
}
