import '../models/credit_model.dart';

abstract class CreditRemoteDataSource {
  Future<List<CreditModel>>? getCredits(int? movieID);
}
