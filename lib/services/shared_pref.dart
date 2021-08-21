part of 'services.dart';

class SharedPref {
  static const String _USER_ID = 'userId';

  static SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setUserId(String userId) async {
    bool userIdSaved = await _preferences.setString(_USER_ID, userId);

    return userIdSaved;
  }

  static String getUserId() {
    String userId = _preferences.getString(_USER_ID);

    return userId;
  }

  static Future<bool> clearUserId() async {
    bool userIdRemoved = await _preferences.remove(_USER_ID);

    return userIdRemoved;
  }
}
