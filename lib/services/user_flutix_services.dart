part of 'services.dart';

class UserFlutixServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(UserFlutix userFlutix) async {
    _userCollection.document(userFlutix.id).setData({
      'email': userFlutix.email,
      'name': userFlutix.name,
      'balance': userFlutix.balance,
      'selectedGenres': userFlutix.selectedGenres,
      'selectedLanguage': userFlutix.selectedLanguage,
      'profilePicture': userFlutix.profilePicture ?? ''
    });
  }

  static Future<UserFlutix> getUserFlutix(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();
    return UserFlutix(id, snapshot.data['email'],
        balance: snapshot.data['balance'],
        profilePicture: snapshot.data['profilePicture'],
        selectedGenres: (snapshot.data['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguage: snapshot.data['selectedLanguage'],
        name: snapshot.data['name']);
  }
}