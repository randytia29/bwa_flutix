import '../../../../core/usecases/usecase.dart';
import '../../data/models/ticket_model.dart';
import '../repositories/ticket_repository.dart';
import 'package:equatable/equatable.dart';

class SaveTicket implements Usecase<void, Params> {
  final TicketRepository? repository;

  SaveTicket(this.repository);

  @override
  Future<void> call(Params params) async {
    return await repository?.saveTicket(params.ticket);
  }
}

class Params extends Equatable {
  final TicketModel? ticket;

  const Params({this.ticket});

  @override
  List<Object?> get props => [ticket];
}
