part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  /*Future<User> convertToUser(
      {String name = 'No Name',
      List<String> selectedGenres = const [],
      String selectedLanguage = 'English',
      int balance = 50000}) async {
    IdTokenResult token = await getIdToken();
    return User(this.uid, this.email,
        name: name,
        selectedGenres: selectedGenres,
        selectedLanguage: selectedLanguage,
        balance: balance,
        token: token.token);
  }*/

  UserFlutix convertToUserFlutix(
          {String name = 'No Name',
          List<String> selectedGenres = const [],
          String selectedLanguage = 'English',
          int balance = 50000}) =>
      UserFlutix(this.uid, this.email,
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage,
          balance: balance);

  Future<UserFlutix> fromFireStore() async =>
      await UserFlutixServices.getUserFlutix(this.uid);
}
