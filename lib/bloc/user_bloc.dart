import 'package:bloc/bloc.dart';
import 'package:bwaflutix/injection_container.dart';
import 'package:bwaflutix/models/user.dart';
import 'package:bwaflutix/services/shared_pref.dart';
import '../services/user_services.dart';
import 'package:equatable/equatable.dart';
import '../services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      User user = await UserServices.getUser(event.id);

      emit(UserLoaded(user));
    });

    on<SignOut>((event, emit) async {
      await sl<SharedPref>().clearUserId();
      await AuthServices.signOut();

      emit(UserInitial());
    });

    on<UpdateData>((event, emit) async {
      User updateUser = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profilePicture: event.profileImage);
      await UserServices.updateUser(updateUser);

      emit(UserLoaded(updateUser));
    });

    on<TopUp>((event, emit) async {
      if (state is UserLoaded) {
        try {
          User updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance! + event.amount!);
          await UserServices.updateUser(updatedUser);

          emit(UserLoaded(updatedUser));
        } catch (e) {
          print(e);
        }
      }
    });

    on<Purchase>((event, emit) async {
      if (state is UserLoaded) {
        try {
          User updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance! - event.amount);
          await UserServices.updateUser(updatedUser);

          emit(UserLoaded(updatedUser));
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
