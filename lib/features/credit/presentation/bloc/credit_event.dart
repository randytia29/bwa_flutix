part of 'credit_bloc.dart';

abstract class CreditEvent extends Equatable {
  const CreditEvent();

  @override
  List<Object> get props => [];
}

class FetchCredit extends CreditEvent {
  final int? movieID;

  const FetchCredit({required this.movieID});
}
