import 'dart:convert';

import 'package:bwaflutix/core/error/exceptions.dart';
import 'package:bwaflutix/features/credit/data/datasources/credit_local_data_source.dart';
import 'package:bwaflutix/features/credit/data/models/credit_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  CreditLocalDataSourceImpl? dataSource;
  MockSharedPreferences? mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        CreditLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastCreditList', () {
    final tCreditModelList = List.from(json.decode(fixture('credit_list.json')))
        .map((e) => CreditModel.fromJson(e))
        .toList();

    test(
        'should return CreditList from SharedPreferences when there is on in the cache',
        () async {
      when(mockSharedPreferences?.getString(cachedCreditList))
          .thenReturn(fixture('credit_list.json'));

      final result = await dataSource?.getLastCredits();

      verify(mockSharedPreferences?.getString(cachedCreditList));
      expect(result, equals(tCreditModelList));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      when(mockSharedPreferences?.getString(cachedCreditList)).thenReturn(null);

      expect(() => dataSource?.getLastCredits(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });
}
