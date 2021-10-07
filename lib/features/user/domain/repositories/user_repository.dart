import 'package:bwaflutix/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?>? getUser(String? id);
}
