import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKey {
  static const String USER_ID = 'userId';
}

class SharedPref {
  final SharedPreferences? sharedPreferences;

  SharedPref({required this.sharedPreferences});

  Future<bool> setUserId(String userId) async {
    bool userIdSaved =
        await sharedPreferences!.setString(SharedPrefKey.USER_ID, userId);

    return userIdSaved;
  }

  String? getUserId() {
    String? userId = sharedPreferences!.getString(SharedPrefKey.USER_ID);

    return userId;
  }

  Future<bool> clearUserId() async {
    bool userIdRemoved = await sharedPreferences!.remove(SharedPrefKey.USER_ID);

    return userIdRemoved;
  }
}
