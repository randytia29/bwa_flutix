import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwaflutix/models/models.dart';
import 'package:bwaflutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'user_flutix_event.dart';
part 'user_flutix_state.dart';

class UserFlutixBloc extends Bloc<UserFlutixEvent, UserFlutixState> {
  UserFlutixBloc() : super(UserFlutixInitial());

  @override
  Stream<UserFlutixState> mapEventToState(
    UserFlutixEvent event,
  ) async* {
    if (event is LoadUserFlutix) {
      UserFlutix userFlutix = await UserFlutixServices.getUserFlutix(event.id);
      yield UserFlutixLoaded(userFlutix);
    } else if (event is SignOut) {
      yield UserFlutixInitial();
    } else if (event is UpdateData) {
      UserFlutix updateUserFlutix = (state as UserFlutixLoaded)
          .userFlutix
          .copyWith(name: event.name, profilePicture: event.profileImage);
      await UserFlutixServices.updateUserFlutix(updateUserFlutix);
      yield UserFlutixLoaded(updateUserFlutix);
    } else if (event is TopUp) {
      if (state is UserFlutixLoaded) {
        try {
          UserFlutix updatedUserFlutix = (state as UserFlutixLoaded)
              .userFlutix
              .copyWith(
                  balance: (state as UserFlutixLoaded).userFlutix.balance +
                      event.amount);
          await UserFlutixServices.updateUserFlutix(updatedUserFlutix);
          yield UserFlutixLoaded(updatedUserFlutix);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is Purchase) {
      if (state is UserFlutixLoaded) {
        try {
          UserFlutix updatedUserFlutix = (state as UserFlutixLoaded)
              .userFlutix
              .copyWith(
                  balance: (state as UserFlutixLoaded).userFlutix.balance -
                      event.amount);
          await UserFlutixServices.updateUserFlutix(updatedUserFlutix);
          yield UserFlutixLoaded(updatedUserFlutix);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
