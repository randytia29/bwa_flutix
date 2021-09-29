import '../../../../core/usecases/usecase.dart';
import '../entities/ticket.dart';
import '../repositories/ticket_repository.dart';
import 'package:equatable/equatable.dart';

class GetTickets implements Usecase<List<Ticket>, Params> {
  final TicketRepository? repository;

  GetTickets(this.repository);

  @override
  Future<List<Ticket>?> call(Params params) async {
    return await repository?.getTickets(params.userId);
  }
}

class Params extends Equatable {
  final String? userId;

  Params({this.userId});

  @override
  List<Object?> get props => [userId];
}
