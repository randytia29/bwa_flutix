part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.doc().set({
      'movieID': ticket.movie!.id,
      'userID': id,
      'theaterName': ticket.theater!.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice
    });
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.get();

    var documents =
        snapshot.docs.where((document) => document['userID'] == userId);
    List<Ticket> tickets = [];
    for (var document in documents) {
      final movie = await MovieServices.getDetails(document['movieID']);
      tickets.add(Ticket(
          movie,
          Theater(document['theaterName']),
          DateTime.fromMillisecondsSinceEpoch(document['time']),
          document['bookingCode'],
          document['seats'].toString().split(','),
          document['name'],
          document['totalPrice']));
    }
    return tickets;
  }
}
