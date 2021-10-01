part of 'order_transaction_bloc.dart';

abstract class OrderTransactionEvent extends Equatable {
  const OrderTransactionEvent();

  @override
  List<Object> get props => [];
}

class PostTransaction extends OrderTransactionEvent {
  final String? userID;
  final String? title;
  final String? subtitle;
  final int? amount;
  final DateTime? time;
  final String? picture;

  PostTransaction(
      {this.userID,
      this.title,
      this.subtitle,
      this.amount,
      this.time,
      this.picture});
}
