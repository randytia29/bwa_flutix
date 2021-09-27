import 'package:bwaflutix/models/user.dart';
import 'package:bwaflutix/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

extension FirebaseUserExtension on auth.User {
  User convertToUser(
          {String name = 'No Name',
          List<String> selectedGenres = const [],
          String selectedLanguage = 'English',
          int balance = 50000}) =>
      User(this.uid, this.email,
          name: name,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
