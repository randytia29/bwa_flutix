part of 'credit_bloc.dart';

abstract class CreditState extends Equatable {
  const CreditState();

  @override
  List<Object> get props => [];
}

class CreditInitial extends CreditState {}

class CreditLoading extends CreditState {}

class CreditLoaded extends CreditState {
  final List<Credit>? credits;

  const CreditLoaded({required this.credits});
}

class CreditFailToLoad extends CreditState {
  final String? message;

  const CreditFailToLoad({required this.message});
}
