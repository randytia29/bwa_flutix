import 'package:bloc/bloc.dart';
import '../../data/models/ticket_model.dart';
import '../../domain/usecases/save_ticket.dart';
import 'package:equatable/equatable.dart';

part 'order_ticket_event.dart';
part 'order_ticket_state.dart';

class OrderTicketBloc extends Bloc<OrderTicketEvent, OrderTicketState> {
  final SaveTicket? saveTicket;

  OrderTicketBloc({required SaveTicket? ticket})
      : assert(ticket != null),
        saveTicket = ticket,
        super(OrderTicketState.initial()) {
    on<InitOrderTicketProcess>((event, emit) {
      emit(state.copyWith(
          movieId: event.movieId,
          movieTitle: event.movieTitle,
          movieVoteAverage: event.movieVoteAverage,
          movieOverview: event.movieOverview,
          moviePosterPath: event.moviePosterPath,
          movieBackdropPath: event.movieBackdropPath,
          movieLanguage: event.movieLanguage,
          movieGenres: event.movieGenres,
          id: event.id,
          theaterName: event.theaterName,
          time: event.time,
          bookingCode: event.bookingCode,
          name: event.name));
    });

    on<SeatsSelected>((event, emit) {
      final totalPrice = 26500 * event.seats!.length;

      emit(state.copyWith(seats: event.seats, totalPrice: totalPrice));
    });

    // on<TotalPriceSelected>((event, emit) {
    //   final currentState = state;
    //   if (currentState is OrderTicketProcess) {
    //     emit(currentState.copyWith(totalPrice: event.totalPrice));
    //   }
    // });

    on<BuyTicket>((event, emit) async {
      await saveTicket!(Params(ticket: state.toTicketModel()));

      emit(state);
    });
  }
}
