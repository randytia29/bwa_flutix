import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKey {
  static const String userId = 'userId';
}

class SharedPref {
  final SharedPreferences? sharedPreferences;

  SharedPref({required this.sharedPreferences});

  Future<bool> setUserId(String userId) async {
    bool userIdSaved =
        await sharedPreferences!.setString(SharedPrefKey.userId, userId);

    return userIdSaved;
  }

  String? getUserId() {
    String? userId = sharedPreferences!.getString(SharedPrefKey.userId);

    return userId;
  }

  Future<bool> clearUserId() async {
    bool userIdRemoved = await sharedPreferences!.remove(SharedPrefKey.userId);

    return userIdRemoved;
  }
}
