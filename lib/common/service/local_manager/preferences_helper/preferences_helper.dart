import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_helper.impl.dart';

abstract class PreferencesHelper {
  Future<PreferencesHelper> init();

  SharedPreferences? getPrefs();

  Future<bool>? clear();

  void saveData<T>(String key, T? data);

  dynamic getData(String key);

  Future<bool>? remove(String key);
}
