import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../shared/shared_value.dart';
import '../models/credit_model.dart';

abstract class CreditRemoteDataSource {
  Future<List<CreditModel>>? getCredits(int? movieID);
}

class CreditRemoteDataSourceImpl implements CreditRemoteDataSource {
  final http.Client? client;

  CreditRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CreditModel>>? getCredits(int? movieID) async {
    final url =
        Uri.https(baseUrl, '/3/movie/$movieID/credits', {'api_key': apiKey});

    final response = await client?.get(url);

    if (response?.statusCode == 200) {
      final data = json.decode(response!.body);

      return List.from(data['cast'])
          .map((e) => CreditModel.fromJson(e))
          .take(8)
          .toList();
    } else {
      throw ServerException();
    }
  }
}
