import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../injection_container.dart';
import '../services/shared_pref.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<CheckIsAuthenticated>((event, emit) {
      String? userId = sl<SharedPref>().getUserId();

      if (userId == null || userId.isEmpty) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated(userId));
      }
    });
  }
}
