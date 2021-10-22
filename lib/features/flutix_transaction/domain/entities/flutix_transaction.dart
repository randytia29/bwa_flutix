import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'flutix_transaction.g.dart';

@HiveType(typeId: 0)
class FlutixTransaction extends Equatable {
  @HiveField(0)
  final String userID;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String subtitle;
  @HiveField(3)
  final int amount;
  @HiveField(4)
  final DateTime time;
  @HiveField(5)
  final String picture;

  const FlutixTransaction(
      {required this.userID,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.time,
      required this.picture});

  @override
  List<Object?> get props => [userID, title, subtitle, amount, time, picture];
}
