part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final List<Ticket>? tickets;

  TicketLoaded({required this.tickets});
}

class TicketFailToLoad extends TicketState {
  final String? message;

  TicketFailToLoad({required this.message});
}
