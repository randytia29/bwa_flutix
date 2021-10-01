part of 'flutix_transaction_bloc.dart';

abstract class FlutixTransactionEvent extends Equatable {
  const FlutixTransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchFlutixTransaction extends FlutixTransactionEvent {}
