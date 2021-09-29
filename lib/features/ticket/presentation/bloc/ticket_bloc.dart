import 'package:bloc/bloc.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/usecases/get_tickets.dart';
import 'package:equatable/equatable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final GetTickets? getTickets;

  TicketBloc({required GetTickets? tickets})
      : assert(tickets != null),
        getTickets = tickets,
        super(TicketInitial()) {
    on<FetchTicket>((event, emit) async {
      emit(TicketLoading());
      try {
        final tickets = await getTickets!(Params(userId: event.userId));

        emit(TicketLoaded(tickets: tickets));
      } catch (e) {
        emit(TicketFailToLoad(message: e.toString()));
      }
    });
  }
}
