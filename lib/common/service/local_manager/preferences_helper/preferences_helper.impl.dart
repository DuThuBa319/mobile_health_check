part of 'preferences_helper.dart';

class PreferencesHelperImpl extends PreferencesHelper {
  SharedPreferences? prefs;

  @override
  Future<PreferencesHelper> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  @override
  SharedPreferences? getPrefs() {
    return prefs;
  }

  @override
  Future<bool>? clear() {
    return prefs?.clear();
  }

  @override
  void saveData<T>(String key, T? data) {
    if (data == null) {
      prefs?.remove(key);
      return;
    }
    if (data is String) {
      prefs?.setString(key, data);
    }
    if (data is bool) {
      prefs?.setBool(key, data);
    }
    if (data is int) {
      prefs?.setInt(key, data);
    }
    if (data is double) {
      prefs?.setDouble(key, data);
    }

    if (data is List<String>) {
      prefs?.setStringList(key, data);
    }
  }

  @override
  dynamic getData(String key) {
    final value = prefs?.get(key);
    return value;
  }

  @override
  Future<bool>? remove(String key) {
    return prefs?.remove(key);
  }

  
}
