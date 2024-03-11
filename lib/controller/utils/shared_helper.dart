import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static late SharedPreferences _sharedPreferences;
  static const String databasePathKey = 'database_path';
  static const String activeRouteKey = 'active_route';

  static void init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    }
    // value is List<String>
    return await _sharedPreferences.setStringList(key, value);
  }

  static dynamic getData({required String key, dynamic valueDataType}) {
    if (valueDataType != null) {
      if (valueDataType is String) {
        return _sharedPreferences.getString(key);
      }
      if (valueDataType is bool) {
        return _sharedPreferences.getBool(key);
      }
      if (valueDataType is int) {
        return _sharedPreferences.getInt(key);
      }
      if (valueDataType is double) {
        return _sharedPreferences.getDouble(key);
      }
      // value is List<String>
      return _sharedPreferences.getStringList(key);
    } else {
      // if not found return null
      return _sharedPreferences.get(key);
    }
  }
}
