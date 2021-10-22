import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final int movieId;
  final String movieTitle;
  final double movieVoteAverage;
  final String movieOverview;
  final String moviePosterPath;
  final String movieBackdropPath;
  final String movieLanguage;
  final List<String> movieGenres;
  final String id;
  final String theaterName;
  final DateTime time;
  final String bookingCode;
  final List<String> seats;
  final String name;
  final int totalPrice;

  const Ticket(
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
