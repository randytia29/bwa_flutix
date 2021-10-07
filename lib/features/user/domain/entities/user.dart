import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedGenres;
  final String selectedLanguage;
  final int balance;

  User(
      {required this.email,
      required this.name,
      required this.profilePicture,
      required this.selectedGenres,
      required this.selectedLanguage,
      required this.balance});

  @override
  List<Object?> get props =>
      [email, name, profilePicture, selectedGenres, selectedLanguage, balance];
}
