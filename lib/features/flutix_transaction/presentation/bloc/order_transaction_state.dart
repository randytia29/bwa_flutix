part of 'order_transaction_bloc.dart';

class OrderTransactionState extends Equatable {
  final String? userID;
  final String? title;
  final String? subtitle;
  final int? amount;
  final DateTime? time;
  final String? picture;

  OrderTransactionState(
      {required this.userID,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.time,
      required this.picture});

  factory OrderTransactionState.initial() {
    return OrderTransactionState(
        userID: '',
        title: '',
        subtitle: '',
        amount: 0,
        time: DateTime.now(),
        picture: '');
  }

  OrderTransactionState copyWith(
      {String? userID,
      String? title,
      String? subtitle,
      int? amount,
      DateTime? time,
      String? picture}) {
    return OrderTransactionState(
        userID: userID ?? this.userID,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        amount: amount ?? this.amount,
        time: time ?? this.time,
        picture: picture ?? this.picture);
  }

  FlutixTransactionModel toFlutixTransactionModel() {
    return FlutixTransactionModel(
        userID: userID!,
        title: title!,
        subtitle: subtitle!,
        amount: amount!,
        time: time!,
        picture: picture!);
  }

  @override
  List<Object?> get props => [userID, title, subtitle, amount, time, picture];
}
