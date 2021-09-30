import '../models/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.get();

    var documents =
        snapshot.docs.where((document) => document['userID'] == userId);

    final tickets = documents.map((e) => Ticket.fromJson(e)).toList();

    return tickets;
  }
}
