part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await transactionCollection.doc().set({
      'userID': flutixTransaction.userID,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'amount': flutixTransaction.amount,
      'time': flutixTransaction.time.millisecondsSinceEpoch,
      'picture': flutixTransaction.picture
    });
  }

  static Future<List<FlutixTransaction>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await transactionCollection.get();

    var documents =
        snapshot.docs.where((document) => document['userID'] == userID);

    final flutixTransactions = documents
        .map((e) => FlutixTransaction(
            userID: e['userID'],
            title: e['title'],
            subtitle: e['subtitle'],
            amount: e['amount'],
            time: DateTime.fromMillisecondsSinceEpoch(e['time']),
            picture: e['picture']))
        .toList();

    return flutixTransactions;
  }
}
