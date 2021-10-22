part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String id;

  const LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateData extends UserEvent {
  final String? name;
  final String? profileImage;

  const UpdateData({this.name, this.profileImage});

  @override
  List<Object?> get props => [name, profileImage];
}

class TopUp extends UserEvent {
  final int? amount;

  const TopUp(this.amount);

  @override
  List<Object?> get props => [amount];
}

class Purchase extends UserEvent {
  final int amount;

  const Purchase(this.amount);

  @override
  List<Object> get props => [amount];
}
