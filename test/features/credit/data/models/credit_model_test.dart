import 'dart:convert';

import 'package:bwaflutix/features/credit/data/models/credit_model.dart';
import 'package:bwaflutix/features/credit/domain/entities/credit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tCreditModel = CreditModel(
      name: 'Kostja Ullmann', profilePath: '/mQguH03eznJhsfwpZJZrnWCs5Su.jpg');

  test('should be subclass of Credit Entity', () async {
    expect(tCreditModel, isA<Credit>());
  });

  group('fromJson', () {
    test('should return a valid credit model', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('credit.json'));

      final result = CreditModel.fromJson(jsonMap);

      expect(result, tCreditModel);
    });
  });

  group('toJson', () {
    test('should return a JSON Credit map', () async {
      final result = tCreditModel.toJson();

      final expectedMap = {
        'name': 'Kostja Ullmann',
        'profile_path': '/mQguH03eznJhsfwpZJZrnWCs5Su.jpg'
      };
      expect(result, expectedMap);
    });
  });
}
