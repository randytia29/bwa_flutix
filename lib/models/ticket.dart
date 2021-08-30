part of 'models.dart';

class Ticket extends Equatable {
  final Movie? movie;
  final Theater? theater;
  final DateTime time;
  final String? bookingCode;
  final List<String>? seats;
  final String? name;
  final int? totalPrice;

  Ticket(this.movie, this.theater, this.time, this.bookingCode, this.seats,
      this.name, this.totalPrice);

  Ticket copyWith(
          {Movie? movie,
          Theater? theater,
          DateTime? time,
          String? bookingCode,
          List<String>? seats,
          String? name,
          int? totalPrice}) =>
      Ticket(
          movie ?? this.movie,
          theater ?? this.theater,
          time ?? this.time,
          bookingCode ?? this.bookingCode,
          seats ?? this.seats,
          name ?? this.name,
          totalPrice ?? this.totalPrice);

  String get seatsInString {
    String s = '';
    for (var seat in seats!) {
      s += seat + ((seat != seats!.last) ? ', ' : '');
    }
    return s;
  }

  @override
  List<Object?> get props =>
      [movie, theater, time, bookingCode, seats, name, totalPrice];
}
