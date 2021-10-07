import 'package:bwaflutix/features/user/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends User {
  UserModel(
      {required String email,
      required String name,
      required String profilePicture,
      required List<String> selectedGenres,
      required String selectedLanguage,
      required int balance})
      : super(
            email: email,
            name: name,
            profilePicture: profilePicture,
            selectedGenres: selectedGenres,
            selectedLanguage: selectedLanguage,
            balance: balance);

  factory UserModel.fromJson(QueryDocumentSnapshot document) {
    return UserModel(
        email: document['email'],
        name: document['name'],
        profilePicture: document['profilePicture'],
        selectedGenres: (document['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguage: document['selectedLanguage'],
        balance: document['balance']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'profilePicture': profilePicture,
      'selectedGenres': selectedGenres,
      'selectedLanguage': selectedLanguage,
      'balance': balance
    };
  }
}
