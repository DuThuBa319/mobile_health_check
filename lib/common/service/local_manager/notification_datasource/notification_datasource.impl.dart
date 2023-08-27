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
    await localDataManager.secureStorage.deleteAll();
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
  int get unreadCount =>
      localDataManager.preferencesHelper.getData("unreadCount");

  // @override
  // User? getUser() {
  //   final data = localDataManager.preferencesHelper.getData("user") as String?;
  //   if (data == null || data == '' || data == 'null') {
  //     return null;
  //   }
  //   return UserModel.fromJson(
  //     jsonDecode(data) as Map<String, dynamic>,
  //   );
  // }

  // @override
  // Future<void> setUser(UserModel? user) async {
  //   final jsonObj = jsonEncode(user?.toJson());
  //   localDataManager.preferencesHelper.saveData("user", jsonObj);
  // }
  @override
  Future<void> saveUnreadNotificationCount(int count) async {
    localDataManager.preferencesHelper.saveData("unreadCount", count);
  }

  @override
  Future<void> increaseUnreadNotificationCount() async {
    int newCount =
        localDataManager.preferencesHelper.getData("unreadCount") + 1;

    localDataManager.preferencesHelper.saveData("unreadCount", newCount);
  }

  @override
  Future<void> decreaseUnreadNotificationCount() async {
    int newCount =
        localDataManager.preferencesHelper.getData("unreadCount") - 1;

    localDataManager.preferencesHelper.saveData("unreadCount", newCount);
  }
}
