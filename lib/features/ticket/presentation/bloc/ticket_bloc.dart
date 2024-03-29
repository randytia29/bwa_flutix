import 'package:bwaflutix/services/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/usecases/get_tickets.dart';
import 'package:equatable/equatable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final GetTickets? getTickets;
  final SharedPref? sharedPref;

  TicketBloc({required GetTickets? tickets, required SharedPref? pref})
      : assert(tickets != null),
        assert(pref != null),
        getTickets = tickets,
        sharedPref = pref,
        super(TicketInitial()) {
    on<FetchTicket>((event, emit) async {
      emit(TicketLoading());
      try {
        final userId = sharedPref?.getUserId();
        final tickets = await getTickets!(Params(userId: userId));
        tickets?.sort((a, b) => b.time.compareTo(a.time));

        if ((tickets ?? <Ticket>[]).isNotEmpty) {
          emit(TicketLoaded(tickets: tickets));
        } else {
          emit(TicketEmpty());
        }
      } catch (e) {
        emit(TicketFailToLoad(message: e.toString()));
      }
    });
  }
}
