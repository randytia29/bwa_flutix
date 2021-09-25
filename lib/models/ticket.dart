part of 'models.dart';

class Ticket extends Equatable {
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
  final DateTime time;
  final String? bookingCode;
  final String? seats;
  final String? name;
  final int? totalPrice;

  Ticket(
    this.movieId,
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
    this.totalPrice,
  );

  Ticket copyWith({
    int? movieId,
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
    int? totalPrice,
  }) =>
      Ticket(
        movieId ?? this.movieId,
        movieTitle ?? this.movieTitle,
        movieVoteAverage ?? this.movieVoteAverage,
        movieOverview ?? this.movieOverview,
        moviePosterPath ?? this.moviePosterPath,
        movieBackdropPath ?? this.movieBackdropPath,
        movieLanguage ?? this.movieLanguage,
        movieGenres ?? this.movieGenres,
        id ?? this.id,
        theaterName ?? this.theaterName,
        time ?? this.time,
        bookingCode ?? this.bookingCode,
        seats ?? this.seats,
        name ?? this.name,
        totalPrice ?? this.totalPrice,
      );

  factory Ticket.fromJson(QueryDocumentSnapshot document) {
    final rawGenres = List.from(document['movieGenres']);
    final genres = rawGenres.map<String>((e) => e).toList();

    return Ticket(
        document['movieID'],
        document['movieTitle'],
        document['movieVoteAverage'],
        document['movieOverview'],
        document['moviePosterPath'],
        document['movieBackdropPath'],
        document['movieLanguage'],
        genres,
        document['userID'],
        document['theaterName'],
        DateTime.fromMillisecondsSinceEpoch(document['time']),
        document['bookingCode'],
        document['seats'],
        document['name'],
        document['totalPrice']);
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

  // String get seatsInString {
  //   String s = '';
  //   for (var seat in seats!) {
  //     s += seat + ((seat != seats!.last) ? ', ' : '');
  //   }
  //   return s;
  // }

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
