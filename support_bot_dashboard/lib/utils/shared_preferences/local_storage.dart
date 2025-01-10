import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _startDateKey = 'startDate';
  static const _endDateKey = 'endDate';
  Future<String?> getString(String localStorageKey) async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(localStorageKey);
    return result;
  }

  Future<bool> setString(
    String value, {
    required String localStorageKey,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(localStorageKey, value);
  }

  Future<bool?> getBool(String localStorageKey) async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool(localStorageKey);
    return result;
  }

  Future<bool> setBool(
    String localStorageKey,
    bool value,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(localStorageKey, value);
  }

  Future<bool> remove({required String localStorageKey}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(localStorageKey);
  }

  static Future<void> saveSelectedDates(
      DateTime? startDate, DateTime? endDate) async {
    final prefs = await SharedPreferences.getInstance();

    if (startDate != null) {
      await prefs.setString(_startDateKey, startDate.toIso8601String());
    } else {
      await prefs.remove(_startDateKey);
    }

    if (endDate != null) {
      await prefs.setString(_endDateKey, endDate.toIso8601String());
    } else {
      await prefs.remove(_endDateKey);
    }
  }

  /// Retrieves the saved start and end dates from local storage.
  static Future<List<DateTime?>> getSelectedDates() async {
    final prefs = await SharedPreferences.getInstance();

    final startDateString = prefs.getString(_startDateKey);
    final endDateString = prefs.getString(_endDateKey);

    final startDate =
        startDateString != null ? DateTime.tryParse(startDateString) : null;
    final endDate =
        endDateString != null ? DateTime.tryParse(endDateString) : null;

    return [startDate, endDate];
  }
}
