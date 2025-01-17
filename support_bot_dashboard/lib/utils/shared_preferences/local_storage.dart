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

  static const String _pipelineKey = "pipeline_id";
  static const String piplineid = "pipliners_id";
  static const String _bopsStateKey = "bops_state";
  static const String _classificationKey = "classification";
  static const String _validationKey = "validation";
  static const String _selectedDatesKey = "selected_dates";
  static const String _pipelineIdsKeys = 'pipelineIds';

  static Future<void> savePipeline(String pipelineId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_pipelineKey, pipelineId);
  }

  static Future<void> savePipelineIds(List<String> pipelineIds) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_pipelineIdsKeys, pipelineIds);
    } catch (e) {}
  }

  static Future<List<String>> getPipelineIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_pipelineIdsKeys) ?? [];
    } catch (e) {
      return [];
    }
  }

  /// Clear pipeline IDs from local storage
  static Future<void> clearPipelineIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pipelineIdsKeys);
    } catch (e) {}
  }

  static Future<void> saveBopsState(String? state) async {
    final prefs = await SharedPreferences.getInstance();
    if (state != null) {
      prefs.setString(_bopsStateKey, state);
    } else {
      prefs.remove(_bopsStateKey);
    }
  }

  static Future<void> saveClassification(String? classification) async {
    final prefs = await SharedPreferences.getInstance();
    if (classification != null) {
      prefs.setString(_classificationKey, classification);
    } else {
      prefs.remove(_classificationKey);
    }
  }

  static Future<void> saveValidation(String? validation) async {
    final prefs = await SharedPreferences.getInstance();
    if (validation != null) {
      prefs.setString(_validationKey, validation);
    } else {
      prefs.remove(_validationKey);
    }
  }

  static Future<String?> getPipeline() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_pipelineKey);
  }

  static Future<String?> getBopsState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_bopsStateKey);
  }

  static Future<String?> getClassification() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_classificationKey);
  }

  static Future<String?> getValidation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_validationKey);
  }

  // Clear methods
  static Future<void> clearPipeline() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_pipelineKey);
  }

  static Future<void> clearBopsState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_bopsStateKey);
  }

  static Future<void> clearClassification() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_classificationKey);
  }

  static Future<void> clearValidation() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_validationKey);
  }

  // Clear selected dates (if you store them as strings or another format)
  static Future<void> clearSelectedDates() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_selectedDatesKey);
  }

  static Future<void> clearAllFilters() async {
    await clearPipeline();
    await clearBopsState();
    await clearClassification();
    await clearValidation();
    await clearSelectedDates();
  }
}
