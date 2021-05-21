part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.doc().set({
      'movieID': ticket.movieDetail.id ?? '',
      'userID': id ?? '',
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
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
      MovieDetail movieDetail =
          await MovieServices.getDetails(null, movieID: document['movieID']);
      tickets.add(Ticket(
          movieDetail,
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
