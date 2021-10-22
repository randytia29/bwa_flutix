import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/ticket_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TicketLocalDataSource {
  Future<List<TicketModel>>? getLastTickets();
  Future<void>? cacheTickets(List<TicketModel>? ticketsToCache);
}

const cachedTicketList = 'CACHED_TICKET_LIST';

class TicketLocalDataSourceImpl implements TicketLocalDataSource {
  final SharedPreferences? sharedPreferences;

  TicketLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheTickets(List<TicketModel>? ticketsToCache) {
    final jsonMap = ticketsToCache?.map((e) => e.toJson()).toList();
    final jsonString = json.encode(jsonMap);

    return sharedPreferences?.setString(cachedTicketList, jsonString);
  }

  @override
  Future<List<TicketModel>>? getLastTickets() {
    final jsonString = sharedPreferences?.getString(cachedTicketList);
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
