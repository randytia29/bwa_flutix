import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/ticket_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TicketLocalDataSource {
  Future<List<TicketModel>>? getLastTickets();
  Future<void>? cacheTickets(List<TicketModel>? ticketsToCache);
}

const CACHED_TICKET_LIST = 'CACHED_TICKET_LIST';

class TicketLocalDataSourceImpl implements TicketLocalDataSource {
  final SharedPreferences? sharedPreferences;

  TicketLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheTickets(List<TicketModel>? ticketsToCache) {
    final jsonMap = ticketsToCache?.map((e) => e.toJson()).toList();
    final jsonString = json.encode(jsonMap);

    return sharedPreferences?.setString(CACHED_TICKET_LIST, jsonString);
  }

  @override
  Future<List<TicketModel>>? getLastTickets() {
    final jsonString = sharedPreferences?.getString(CACHED_TICKET_LIST);
    if (jsonString != null) {
      final response = json.decode(jsonString);
      final result =
          List.from(response).map((e) => TicketModel.fromJson(e)).toList();

      return Future.value(result);
    } else {
      throw CacheException();
    }
  }
}
