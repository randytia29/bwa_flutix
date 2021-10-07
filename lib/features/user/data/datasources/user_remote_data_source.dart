import 'package:bwaflutix/features/user/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRemoteDataSource {
  Future<UserModel>? getUser(String? id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore? firebaseFirestore;

  UserRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<UserModel>? getUser(String? id) async {
    CollectionReference userCollection = firebaseFirestore!.collection('users');
    final snapshot = await userCollection.doc(id).get();

    return UserModel(
        email: snapshot['email'],
        name: snapshot['name'],
        profilePicture: snapshot['profilePicture'],
        selectedGenres: snapshot['selectedGenres'],
        selectedLanguage: snapshot['selectedLanguage'],
        balance: snapshot['balance']);
  }
}
