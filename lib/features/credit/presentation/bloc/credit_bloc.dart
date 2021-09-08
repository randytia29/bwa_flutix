import 'dart:async';

import 'package:bloc/bloc.dart';
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
        super(CreditInitial());

  @override
  Stream<CreditState> mapEventToState(
    CreditEvent event,
  ) async* {
    if (event is FetchCredit) {
      yield CreditLoading();

      final failureOrCredits =
          await getCredits!(Params(movieID: event.movieID));

      yield failureOrCredits!
          .fold((failure) => CreditFailToLoad(message: failure.toString()),
              (credits) {
        credits?.removeWhere((element) =>
            element.profilePath.isEmpty || element.profilePath == '');
        return CreditLoaded(credits: credits);
      });
    }
  }
}
