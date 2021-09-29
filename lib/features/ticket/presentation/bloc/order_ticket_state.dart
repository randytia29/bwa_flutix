part of 'order_ticket_bloc.dart';

abstract class OrderTicketState extends Equatable {
  const OrderTicketState();

  @override
  List<Object> get props => [];
}

class OrderTicketInitial extends OrderTicketState {}

class OrderTicketLoading extends OrderTicketState {}

class OrderTicketProcess extends OrderTicketState {
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
  final String? seats;
  final String? name;
  final int? totalPrice;

  OrderTicketProcess(
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
      this.seats,
      this.name,
      this.totalPrice});

  OrderTicketProcess copyWith(
      {int? movieId,
      String? movieTitle,
      double? movieVoteAverage,
      String? movieOverview,
      String? moviePosterPath,
      String? movieBackdropPath,
      String? movieLanguage,
      List<String>? movieGenres,
      String? id,
      String? theaterName,
      DateTime? time,
      String? bookingCode,
      String? seats,
      String? name,
      int? totalPrice}) {
    return OrderTicketProcess(
        movieId: movieId ?? this.movieId,
        movieTitle: movieTitle ?? this.movieTitle,
        movieVoteAverage: movieVoteAverage ?? this.movieVoteAverage,
        movieOverview: movieOverview ?? this.movieOverview,
        moviePosterPath: moviePosterPath ?? this.moviePosterPath,
        movieBackdropPath: movieBackdropPath ?? this.movieBackdropPath,
        movieLanguage: movieLanguage ?? this.movieLanguage,
        movieGenres: movieGenres ?? this.movieGenres,
        id: id ?? this.id,
        theaterName: theaterName ?? this.theaterName,
        time: time ?? this.time,
        bookingCode: bookingCode ?? this.bookingCode,
        seats: seats ?? this.seats,
        name: name ?? this.name,
        totalPrice: totalPrice ?? this.totalPrice);
  }
}

class OrderTicketSuccess extends OrderTicketState {}

class OrderTicketFailToLoad extends OrderTicketState {
  final String? message;

  OrderTicketFailToLoad({required this.message});
}
