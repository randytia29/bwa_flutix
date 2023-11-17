import '../../domain/entities/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel extends Ticket {
  const TicketModel(
      {required super.movieId,
      required super.movieTitle,
      required super.movieVoteAverage,
      required super.movieOverview,
      required super.moviePosterPath,
      required super.movieBackdropPath,
      required super.movieLanguage,
      required super.movieGenres,
      required super.id,
      required super.theaterName,
      required super.time,
      required super.bookingCode,
      required super.seats,
      required super.name,
      required super.totalPrice});

  factory TicketModel.fromJson(QueryDocumentSnapshot document) {
    return TicketModel(
        movieId: document['movieID'],
        movieTitle: document['movieTitle'],
        movieVoteAverage: document['movieVoteAverage'],
        movieOverview: document['movieOverview'],
        moviePosterPath: document['moviePosterPath'],
        movieBackdropPath: document['movieBackdropPath'],
        movieLanguage: document['movieLanguage'],
        movieGenres:
            (document['movieGenres'] as List).map((e) => e.toString()).toList(),
        id: document['userID'],
        theaterName: document['theaterName'],
        time: DateTime.fromMillisecondsSinceEpoch(document['time']),
        bookingCode: document['bookingCode'],
        seats: (document['seats'] as List).map((e) => e.toString()).toList(),
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
