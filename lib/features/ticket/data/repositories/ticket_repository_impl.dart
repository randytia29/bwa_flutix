import '../../../../core/network/network_info.dart';
import '../datasources/ticket_local_data_source.dart';
import '../datasources/ticket_remote_data_source.dart';
import '../models/ticket_model.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource? remoteDataSource;
  final TicketLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  TicketRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<List<Ticket>?>? getTickets(String? userId) async {
    if ((await networkInfo?.isConnected)!) {
      try {
        final remoteTicket = await remoteDataSource?.getTickets(userId);
        localDataSource?.cacheTickets(remoteTicket);
        return remoteTicket;
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        final localTicket = await localDataSource?.getLastTickets();
        return localTicket;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Future<void>? saveTicket(TicketModel? ticket) async {
    await remoteDataSource?.saveTicket(ticket);
  }
}
