import '../models/ticket_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TicketRemoteDataSource {
  Future<List<TicketModel>>? getTickets(String? userId);
  Future<void>? saveTicket(TicketModel? ticket);
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final FirebaseFirestore? firebaseFirestore;

  TicketRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<List<TicketModel>>? getTickets(String? userId) async {
    CollectionReference ticketCollection =
        firebaseFirestore!.collection('tickets');
    final snapshot = await ticketCollection.get();
    final documents =
        snapshot.docs.where((document) => document['userID'] == userId);
    final tickets = documents.map((e) => TicketModel.fromJson(e)).toList();

    return tickets;
  }

  @override
  Future<void>? saveTicket(TicketModel? ticket) async {
    CollectionReference ticketCollection =
        firebaseFirestore!.collection('tickets');
    await ticketCollection.doc().set(ticket?.toJson());
  }
}
