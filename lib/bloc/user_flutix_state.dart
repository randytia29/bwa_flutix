part of 'user_flutix_bloc.dart';

abstract class UserFlutixState extends Equatable {
  const UserFlutixState();
}

class UserFlutixInitial extends UserFlutixState {
  @override
  List<Object> get props => [];
}

class UserFlutixLoaded extends UserFlutixState {
  final UserFlutix userFlutix;

  UserFlutixLoaded(this.userFlutix);

  @override
  List<Object> get props => [userFlutix];
}
