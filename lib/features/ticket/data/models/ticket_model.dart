import '../../domain/entities/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel extends Ticket {
  TicketModel(
      {required int movieId,
      required String movieTitle,
      required double movieVoteAverage,
      required String movieOverview,
      required String moviePosterPath,
      required String movieBackdropPath,
      required String movieLanguage,
      required List<String> movieGenres,
      required String id,
      required String theaterName,
      required DateTime time,
      required String bookingCode,
      required String seats,
      required String name,
      required int totalPrice})
      : super(
            movieId: movieId,
            movieTitle: movieTitle,
            movieVoteAverage: movieVoteAverage,
            movieOverview: movieOverview,
            moviePosterPath: moviePosterPath,
            movieBackdropPath: movieBackdropPath,
            movieLanguage: movieLanguage,
            movieGenres: movieGenres,
            id: id,
            theaterName: theaterName,
            time: time,
            bookingCode: bookingCode,
            seats: seats,
            name: name,
            totalPrice: totalPrice);

  factory TicketModel.fromJson(QueryDocumentSnapshot document) {
    final rawGenres = List.from(document['movieGenres']);
    final genres = rawGenres.map<String>((e) => e).toList();

    return TicketModel(
        movieId: document['movieID'],
        movieTitle: document['movieTitle'],
        movieVoteAverage: document['movieVoteAverage'],
        movieOverview: document['movieOverview'],
        moviePosterPath: document['moviePosterPath'],
        movieBackdropPath: document['movieBackdropPath'],
        movieLanguage: document['movieLanguage'],
        movieGenres: genres,
        id: document['userID'],
        theaterName: document['theaterName'],
        time: DateTime.fromMillisecondsSinceEpoch(document['time']),
        bookingCode: document['bookingCode'],
        seats: document['seats'],
        name: document['name'],
        totalPrice: document['totalPrice']);
  }

  Map<String, dynamic> toJson() {
    return {
      'movieID': movieId,
      'movieTitle': movieTitle,
      'movieVoteAverage': movieVoteAverage,
      'movieOverview': movieOverview,
      'moviePosterPath': moviePosterPath,
      'movieBackdropPath': movieBackdropPath,
      'movieLanguage': movieLanguage,
      'movieGenres': movieGenres,
      'userID': id,
      'theaterName': theaterName,
      'time': time.millisecondsSinceEpoch,
      'bookingCode': bookingCode,
      'seats': seats,
      'name': name,
      'totalPrice': totalPrice
    };
  }
}
