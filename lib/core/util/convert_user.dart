import 'package:bwaflutix/models/user.dart';
import 'package:bwaflutix/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

User convertToUser(auth.User user,
    {String name = 'No Name',
    List<String> selectedGenres = const [],
    String selectedLanguage = 'English',
    int balance = 50000}) {
  return User(user.uid, user.email,
      name: name,
      balance: balance,
      selectedGenres: selectedGenres,
      selectedLanguage: selectedLanguage);
}

Future<User> fromFireStore(auth.User user) async {
  return await UserServices.getUser(user.uid);
}
