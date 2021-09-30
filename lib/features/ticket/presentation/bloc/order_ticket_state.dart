part of 'order_ticket_bloc.dart';

class OrderTicketState extends Equatable {
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
  final List<String>? seats;
  final String? name;
  final int? totalPrice;

  OrderTicketState(
      {required this.movieId,
      required this.movieTitle,
      required this.movieVoteAverage,
      required this.movieOverview,
      required this.moviePosterPath,
      required this.movieBackdropPath,
      required this.movieLanguage,
      required this.movieGenres,
      required this.id,
      required this.theaterName,
      required this.time,
      required this.bookingCode,
      required this.seats,
      required this.name,
      required this.totalPrice});

  factory OrderTicketState.initial() {
    return OrderTicketState(
        movieId: 0,
        movieTitle: '',
        movieVoteAverage: 0.0,
        movieOverview: '',
        moviePosterPath: '',
        movieBackdropPath: '',
        movieLanguage: '',
        movieGenres: <String>[],
        id: '',
        theaterName: '',
        time: DateTime.now(),
        bookingCode: '',
        seats: <String>[],
        name: '',
        totalPrice: 0);
  }

  OrderTicketState copyWith(
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
      List<String>? seats,
      String? name,
      int? totalPrice}) {
    return OrderTicketState(
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

  TicketModel toTicketModel() {
    return TicketModel(
        movieId: movieId!,
        movieTitle: movieTitle!,
        movieVoteAverage: movieVoteAverage!,
        movieOverview: movieOverview!,
        moviePosterPath: moviePosterPath!,
        movieBackdropPath: movieBackdropPath!,
        movieLanguage: movieLanguage!,
        movieGenres: movieGenres!,
        id: id!,
        theaterName: theaterName!,
        time: time!,
        bookingCode: bookingCode!,
        seats: seats!,
        name: name!,
        totalPrice: totalPrice!);
  }

  @override
  List<Object?> get props => [
        movieId,
        movieTitle,
        movieVoteAverage,
        movieOverview,
        moviePosterPath,
        movieBackdropPath,
        movieLanguage,
        movieGenres,
        id,
        theaterName,
        time,
        bookingCode,
        seats,
        name,
        totalPrice
      ];
}
