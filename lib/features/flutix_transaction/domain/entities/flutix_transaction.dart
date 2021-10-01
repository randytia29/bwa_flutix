import 'package:equatable/equatable.dart';

class FlutixTransaction extends Equatable {
  final String userID;
  final String title;
  final String subtitle;
  final int amount;
  final DateTime time;
  final String picture;

  FlutixTransaction(
      {required this.userID,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.time,
      required this.picture});

  @override
  List<Object?> get props => [userID, title, subtitle, amount, time, picture];
}
