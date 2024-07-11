import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  late SharedPreferences _sharedPreferences;

  SharedPreferenceService() {
    initialize();
  }
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String MEMBER_UID = 'memberUId';

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _sharedPreferences.setString(key, content);
    }
    if (content is bool) {
      _sharedPreferences.setBool(key, content);
    }
    if (content is int) {
      _sharedPreferences.setInt(key, content);
    }
    if (content is double) {
      _sharedPreferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _sharedPreferences.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _sharedPreferences.get(key);
    return value;
  }

  Future<void> clearLoginData() async {
    await _sharedPreferences.remove(MEMBER_UID);
  }

  String get memberUId => _getFromDisk(MEMBER_UID) ?? "";
  set memberUId(String value) => _saveToDisk(MEMBER_UID, value);
}
