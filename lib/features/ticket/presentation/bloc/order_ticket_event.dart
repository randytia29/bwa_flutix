part of 'order_ticket_bloc.dart';

abstract class OrderTicketEvent extends Equatable {
  const OrderTicketEvent();

  @override
  List<Object> get props => [];
}

class InitOrderTicketProcess extends OrderTicketEvent {
  final int? movieId;
  final String? movieTitle;
  final double? movieVoteAverage;
  final String? movieOverview;
  final String? moviePosterPath;
  final String? movieBackdropPath;
  final String? movieLanguage;
  final List<String>? movieGenres;
  final String? id;
  final String? theaterName;
  final DateTime? time;
  final String? bookingCode;
  final String? name;

  InitOrderTicketProcess(
      {this.movieId,
      this.movieTitle,
      this.movieVoteAverage,
      this.movieOverview,
      this.moviePosterPath,
      this.movieBackdropPath,
      this.movieLanguage,
      this.movieGenres,
      this.id,
      this.theaterName,
      this.time,
      this.bookingCode,
      this.name});
}

class SeatsSelected extends OrderTicketEvent {
  final List<String>? seats;

  SeatsSelected(this.seats);
}

class TotalPriceSelected extends OrderTicketEvent {
  final int? totalPrice;

  TotalPriceSelected(this.totalPrice);
}

class BuyTicket extends OrderTicketEvent {}
