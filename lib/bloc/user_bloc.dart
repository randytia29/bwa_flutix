import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwaflutix/models/models.dart';
import 'package:bwaflutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      User user = await UserServices.getUser(event.id);
      yield UserLoaded(user);
    } else if (event is SignOut) {
      await SharedPref.clearUserId();
      await AuthServices.signOut();
      yield UserInitial();
    } else if (event is UpdateData) {
      User updateUser = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profilePicture: event.profileImage);
      await UserServices.updateUser(updateUser);
      yield UserLoaded(updateUser);
    } else if (event is TopUp) {
      if (state is UserLoaded) {
        try {
          User updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance + event.amount);
          await UserServices.updateUser(updatedUser);
          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is Purchase) {
      if (state is UserLoaded) {
        try {
          User updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance - event.amount);
          await UserServices.updateUser(updatedUser);
          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
