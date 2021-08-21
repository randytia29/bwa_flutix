part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final String userId;

  Authenticated(this.userId);

  @override
  List<Object> get props => [userId];
}

class Unauthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}
