import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_credits.dart';
import '../../domain/entities/credit.dart';
import 'package:equatable/equatable.dart';

part 'credit_event.dart';
part 'credit_state.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {
  final GetCredits? getCredits;

  CreditBloc({required GetCredits? credits})
      : assert(credits != null),
        getCredits = credits,
        super(CreditInitial()) {
    on<FetchCredit>((event, emit) async {
      emit(CreditLoading());
      try {
        final credits = await getCredits!(Params(movieID: event.movieID));
        credits?.removeWhere((element) =>
            element.profilePath.isEmpty || element.profilePath == '');

        emit(CreditLoaded(credits: credits));
      } catch (e) {
        emit(CreditFailToLoad(message: e.toString()));
      }
    });
  }
}
