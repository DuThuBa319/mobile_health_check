import 'dart:async';

import 'package:injectable/injectable.dart';

import '../base_datasource.dart';

import 'notification_datasource.dart';

@Injectable(
  as: NotificationDataSource,
)
class NotificationDataSourceImpl extends BaseDataSource
    implements NotificationDataSource {
  @override
  Future<void> clearData() async {
    await localDataManager.preferencesHelper.remove('delayTime');
  }

  // @override
  // Future<String?> getToken() async {
  //   final token =
  //       await localDataManager.secureStorage.read(key: PreferencesKey.token);
  //   return token;
  // }

  // @override
  // Future<void> setToken(String token) async {
  //   await localDataManager.secureStorage.write(
  //     key: PreferencesKey.token,
  //     value: token,
  //   );
  // }

  @override
  int? get delayTime => localDataManager.preferencesHelper.getData("delayTime");
  @override
  int? get localeId => localDataManager.preferencesHelper.getData("localeId");

  @override
  Future<void> saveDelayTime(int delayTime) async {
    localDataManager.preferencesHelper.saveData("delayTime", delayTime);
  }

  @override
  Future<void> saveLocale(int localeId) async {
    localDataManager.preferencesHelper.saveData("localeId", localeId);
  }
}
