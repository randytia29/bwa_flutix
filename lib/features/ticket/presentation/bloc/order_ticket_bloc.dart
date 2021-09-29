import 'package:bloc/bloc.dart';
import 'package:bwaflutix/features/ticket/data/models/ticket_model.dart';
import 'package:bwaflutix/features/ticket/domain/usecases/save_ticket.dart';
import 'package:equatable/equatable.dart';

part 'order_ticket_event.dart';
part 'order_ticket_state.dart';

class OrderTicketBloc extends Bloc<OrderTicketEvent, OrderTicketState> {
  final SaveTicket? saveTicket;

  OrderTicketBloc({required SaveTicket? ticket})
      : assert(ticket != null),
        saveTicket = ticket,
        super(OrderTicketInitial()) {
    on<InitOrderTicketProcess>((event, emit) {
      emit(OrderTicketProcess(
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
      final currentState = state;
      if (currentState is OrderTicketProcess) {
        emit(currentState.copyWith(seats: event.seats));
      }
    });

    on<TotalPriceSelected>((event, emit) {
      final currentState = state;
      if (currentState is OrderTicketProcess) {
        emit(currentState.copyWith(totalPrice: event.totalPrice));
      }
    });

    on<BuyTicket>((event, emit) async {
      final currentState = state;

      if (currentState is OrderTicketProcess) {
        final ticketModel = TicketModel(
            movieId: currentState.movieId!,
            movieTitle: currentState.movieTitle!,
            movieVoteAverage: currentState.movieVoteAverage!,
            movieOverview: currentState.movieOverview!,
            moviePosterPath: currentState.moviePosterPath!,
            movieBackdropPath: currentState.movieBackdropPath!,
            movieLanguage: currentState.movieLanguage!,
            movieGenres: currentState.movieGenres!,
            id: currentState.id!,
            theaterName: currentState.theaterName!,
            time: currentState.time!,
            bookingCode: currentState.bookingCode!,
            seats: currentState.seats!,
            name: currentState.name!,
            totalPrice: currentState.totalPrice!);

        try {
          await saveTicket!(Params(ticket: ticketModel));
          emit(OrderTicketSuccess());
        } catch (e) {
          emit(OrderTicketFailToLoad(message: e.toString()));
        }
      }
    });
  }
}
