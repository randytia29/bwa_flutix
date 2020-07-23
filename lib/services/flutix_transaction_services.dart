part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await transactionCollection.document().setData({
      'userID': flutixTransaction.userID,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'amount': flutixTransaction.amount,
      'time': flutixTransaction.time.millisecondsSinceEpoch,
      'picture': flutixTransaction.picture
    });
  }

  static Future<List<FlutixTransaction>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await transactionCollection.getDocuments();
    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userID);
    return documents
        .map((e) => FlutixTransaction(
            userID: e.data['userID'],
            title: e.data['title'],
            subtitle: e.data['subtitle'],
            amount: e.data['amount'],
            time: DateTime.fromMillisecondsSinceEpoch(e.data['time']),
            picture: e.data['picture']))
        .toList();
  }
}
