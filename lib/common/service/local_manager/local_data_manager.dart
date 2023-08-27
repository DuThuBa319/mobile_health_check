import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'preferences_helper/preferences_helper.dart';

class LocalDataManager {
  late PreferencesHelper _preferencesHelper;
  late FlutterSecureStorage _secureStorage;

  LocalDataManager() {
    init();
  }

  void init() {
    _secureStorage = const FlutterSecureStorage();
    _preferencesHelper = PreferencesHelperImpl();
    _preferencesHelper.init();
  }

  PreferencesHelper get preferencesHelper => _preferencesHelper;

  FlutterSecureStorage get secureStorage => _secureStorage;
}
