part of 'user_flutix_bloc.dart';

abstract class UserFlutixEvent extends Equatable {
  const UserFlutixEvent();
}

class LoadUserFlutix extends UserFlutixEvent {
  final String id;

  LoadUserFlutix(this.id);

  @override
  List<Object> get props => [id];
}

class SignOut extends UserFlutixEvent {
  @override
  List<Object> get props => [];
}

class UpdateData extends UserFlutixEvent {
  final String name;
  final String profileImage;

  UpdateData({this.name, this.profileImage});

  @override
  List<Object> get props => [name, profileImage];
}

class TopUp extends UserFlutixEvent {
  final int amount;

  TopUp(this.amount);

  @override
  List<Object> get props => [amount];
}

class Purchase extends UserFlutixEvent {
  final int amount;

  Purchase(this.amount);

  @override
  List<Object> get props => [amount];
}
