part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(Ticket ticket) async {
    await ticketCollection.doc().set(ticket.toJson());
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.get();

    var documents =
        snapshot.docs.where((document) => document['userID'] == userId);

    final tickets = documents.map((e) => Ticket.fromJson(e)).toList();

    return tickets;
  }
}
