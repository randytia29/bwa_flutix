import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FlutixTransactionModel extends FlutixTransaction {
  const FlutixTransactionModel(
      {required String userID,
      required String title,
      required String subtitle,
      required int amount,
      required DateTime time,
      required String picture})
      : super(
            userID: userID,
            title: title,
            subtitle: subtitle,
            amount: amount,
            time: time,
            picture: picture);

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
