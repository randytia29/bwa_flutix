import 'package:bloc/bloc.dart';
import '../models/ticket.dart';
import '../services/ticket_services.dart';
import 'package:equatable/equatable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketState([])) {
    on<BuyTicket>((event, emit) async {
      await TicketServices.saveTicket(event.ticket);
      List<Ticket> tickets = state.tickets + [event.ticket];

      emit(TicketState(tickets));
    });

    on<GetTickets>((event, emit) async {
      List<Ticket> tickets = await TicketServices.getTickets(event.userID);

      emit(TicketState(tickets));
    });
  }
}
