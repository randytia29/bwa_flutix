import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwaflutix/injection_container.dart';
import 'package:bwaflutix/services/shared_pref.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is CheckIsAuthenticated) {
      String? userId = sl<SharedPref>().getUserId();

      if (userId == null || userId.isEmpty) {
        yield Unauthenticated();
      } else {
        yield Authenticated(userId);
      }
    }
  }
}
