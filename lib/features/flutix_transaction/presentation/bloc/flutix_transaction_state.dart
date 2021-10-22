part of 'flutix_transaction_bloc.dart';

abstract class FlutixTransactionState extends Equatable {
  const FlutixTransactionState();

  @override
  List<Object> get props => [];
}

class FlutixTransactionInitial extends FlutixTransactionState {}

class FlutixTransactionLoading extends FlutixTransactionState {}

class FlutixTransactionEmpty extends FlutixTransactionState {}

class FlutixTransactionLoaded extends FlutixTransactionState {
  final List<FlutixTransaction>? flutixTransactions;

  const FlutixTransactionLoaded({required this.flutixTransactions});
}

class FlutixTransactionFailToLoad extends FlutixTransactionState {
  final String? message;

  const FlutixTransactionFailToLoad({required this.message});
}
