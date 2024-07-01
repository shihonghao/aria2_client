import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  /// 保存数据
  static saveData<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (T) {
      case const (String):
        prefs.setString(key, value as String);
        break;
      case const (int):
        prefs.setInt(key, value as int);
        break;
      case const (bool):
        prefs.setBool(key, value as bool);
        break;
      case const (double):
        prefs.setDouble(key, value as double);
        break;
    }
  }

  /// 读取数据
  static Future<T?> getData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    T? res ;
    switch (T) {
      case const (String):
        res = prefs.getString(key) == null ? null : prefs.getString(key) as T;
        break;
      case const (int):
        res = prefs.getInt(key) == null ? null : prefs.getInt(key) as T;
        break;
      case const (bool):
        res = prefs.getBool(key) == null ? null : prefs.getBool(key) as T;
        break;
      case const (double):
        res = prefs.getDouble(key) == null ? null : prefs.getDouble(key) as T;
        break;
        default:
          res = null;
    }
    return res;
  }
}
