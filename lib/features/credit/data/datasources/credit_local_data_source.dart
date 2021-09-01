import '../models/credit_model.dart';

abstract class CreditLocalDataSource {
  Future<List<CreditModel>?>? getLastCredits();
  Future<void>? cacheCredits(List<CreditModel>? creditToCache);
}
