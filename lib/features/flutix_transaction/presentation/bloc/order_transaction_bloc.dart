import 'package:bloc/bloc.dart';
import 'package:bwaflutix/features/flutix_transaction/data/models/flutix_transaction_model.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/usecases/save_transaction.dart';
import 'package:equatable/equatable.dart';

part 'order_transaction_event.dart';
part 'order_transaction_state.dart';

class OrderTransactionBloc
    extends Bloc<OrderTransactionEvent, OrderTransactionState> {
  final SaveTransaction? saveTransaction;

  OrderTransactionBloc({required SaveTransaction? transaction})
      : assert(transaction != null),
        saveTransaction = transaction,
        super(OrderTransactionState.initial()) {
    on<PostTransaction>((event, emit) async {
      state.copyWith(
          userID: event.userID,
          title: event.title,
          subtitle: event.subtitle,
          amount: event.amount,
          time: event.time,
          picture: event.picture);

      await saveTransaction!(
          Params(flutixTransactionModel: state.toFlutixTransactionModel()));

      emit(state);
    });
  }
}
