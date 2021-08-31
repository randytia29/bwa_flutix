import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../services/services.dart';

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
      String? userId = SharedPref.getUserId();

      if (userId == null || userId.isEmpty) {
        yield Unauthenticated();
      } else {
        yield Authenticated(userId);
      }
    }
  }
}
