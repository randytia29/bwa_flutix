import 'package:bwaflutix/features/ticket/data/models/ticket_model.dart';
import 'package:bwaflutix/features/ticket/domain/entities/ticket.dart';

abstract class TicketRepository {
  Future<void>? saveTicket(TicketModel? ticket);
  Future<List<Ticket>?>? getTickets(String? userId);
}
