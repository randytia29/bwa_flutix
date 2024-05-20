import 'package:bwaflutix/features/user/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends User {
  const UserModel(
      {required super.email,
      required super.name,
      required super.profilePicture,
      required super.selectedGenres,
      required super.selectedLanguage,
      required super.balance});

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
