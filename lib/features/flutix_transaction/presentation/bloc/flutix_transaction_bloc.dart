import 'package:bloc/bloc.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/usecases/get_transactions.dart';
import 'package:bwaflutix/services/shared_pref.dart';
import 'package:equatable/equatable.dart';

part 'flutix_transaction_event.dart';
part 'flutix_transaction_state.dart';

class FlutixTransactionBloc
    extends Bloc<FlutixTransactionEvent, FlutixTransactionState> {
  final GetTransaction? getTransactions;
  final SharedPref? sharedPref;

  FlutixTransactionBloc(
      {required GetTransaction? transactions, required SharedPref? pref})
      : assert(transactions != null),
        assert(pref != null),
        getTransactions = transactions,
        sharedPref = pref,
        super(FlutixTransactionInitial()) {
    on<FetchFlutixTransaction>((event, emit) async {
      emit(FlutixTransactionLoading());
      try {
        final userId = sharedPref?.getUserId();
        final flutixTransactions =
            await getTransactions!(Params(userId: userId));
        flutixTransactions?.sort((a, b) => b.time.compareTo(a.time));

        if (flutixTransactions!.length > 0) {
          emit(FlutixTransactionLoaded(flutixTransactions: flutixTransactions));
        } else {
          emit(FlutixTransactionEmpty());
        }
      } catch (e) {
        emit(FlutixTransactionFailToLoad(message: e.toString()));
      }
    });
  }
}
