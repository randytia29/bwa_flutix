import '../../data/models/ticket_model.dart';
import '../entities/ticket.dart';

abstract class TicketRepository {
  Future<void>? saveTicket(TicketModel? ticket);
  Future<List<Ticket>?>? getTickets(String? userId);
}
