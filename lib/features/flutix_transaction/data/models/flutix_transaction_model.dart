import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FlutixTransactionModel extends FlutixTransaction {
  const FlutixTransactionModel(
      {required super.userID,
      required super.title,
      required super.subtitle,
      required super.amount,
      required super.time,
      required super.picture});

  factory FlutixTransactionModel.fromJson(QueryDocumentSnapshot document) {
    return FlutixTransactionModel(
        userID: document['userID'],
        title: document['title'],
        subtitle: document['subtitle'],
        amount: document['amount'],
        time: DateTime.fromMillisecondsSinceEpoch(document['time']),
        picture: document['picture']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
      'time': time.millisecondsSinceEpoch,
      'picture': picture
    };
  }
}
