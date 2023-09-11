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
    await localDataManager.preferencesHelper.remove('unreadCount');
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
  int? get unreadCount =>
      localDataManager.preferencesHelper.getData("unreadCount");
  @override
  int? get localeId => localDataManager.preferencesHelper.getData("localeId");


  // @override
  // String get id => localDataManager.preferencesHelper.getData("id");
  // @override
  // String get name => localDataManager.preferencesHelper.getData("name");
  // @override
  // int? get age => localDataManager.preferencesHelper.getData("age");
  // @override
  // int? get personType =>
  //     localDataManager.preferencesHelper.getData("personType");
  // @override
  // double? get weight => localDataManager.preferencesHelper.getData("weight");
  // @override
  // double? get height => localDataManager.preferencesHelper.getData("height");
  // @override
  // int? get gender => localDataManager.preferencesHelper.getData("gender");
  // @override
  // String get phoneNumber =>
  //     localDataManager.preferencesHelper.getData("phoneNumber");
  // @override
  // String get street => localDataManager.preferencesHelper.getData("street");
  // @override
  // String get ward => localDataManager.preferencesHelper.getData("ward");
  // @override
  // String get district => localDataManager.preferencesHelper.getData("district");
  // @override
  // String get city => localDataManager.preferencesHelper.getData("city");
  // @override
  // String get country => localDataManager.preferencesHelper.getData("country");

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

  // @override
  // Future<void> savePatientId(String id) async {
  //   localDataManager.preferencesHelper.saveData("id", id);
  // }

  // @override
  // Future<void> savePatientName(String name) async {
  //   localDataManager.preferencesHelper.saveData("name", name);
  // }

  // @override
  // Future<void> savePatientAge(int? age) async {
  //   localDataManager.preferencesHelper.saveData("age", age);
  // }

  // @override
  // Future<void> savePersonType(int personType) async {
  //   localDataManager.preferencesHelper.saveData("personType", personType);
  // }

  // @override
  // Future<void> savePatientWeight(double weight) async {
  //   localDataManager.preferencesHelper.saveData("weight", weight);
  // }

  // @override
  // Future<void> savePatientHeight(double height) async {
  //   localDataManager.preferencesHelper.saveData("height", height);
  // }

  // @override
  // Future<void> savePatientGender(int gender) async {
  //   localDataManager.preferencesHelper.saveData("gender", gender);
  // }

  // @override
  // Future<void> savePatientPhoneNumber(String phoneNumber) async {
  //   localDataManager.preferencesHelper.saveData("phoneNumber", phoneNumber);
  // }

  // @override
  // Future<void> savePatientStreet(String street) async {
  //   localDataManager.preferencesHelper.saveData("street", street);
  // }

  // @override
  // Future<void> savePatientWard(String ward) async {
  //   localDataManager.preferencesHelper.saveData("ward", ward);
  // }

  // @override
  // Future<void> savePatientDistrict(String district) async {
  //   localDataManager.preferencesHelper.saveData("district", district);
  // }

  // @override
  // Future<void> savePatientCity(String city) async {
  //   localDataManager.preferencesHelper.saveData("city", city);
  // }

  // @override
  // Future<void> savePatientCountry(String country) async {
  //   localDataManager.preferencesHelper.saveData("country", country);
  // }

  // @override
  // Future<void> saveUserId(int userId) async {
  //   localDataManager.preferencesHelper.saveData("unreadCount", userId);
  // }
  @override
  Future<void> saveLocale(int localeId) async {
    localDataManager.preferencesHelper.saveData("localeId", localeId);
  }

  

  // @override
  // Future<void> increaseUnreadNotificationCount() async {
  //   int newCount =
  //       (localDataManager.preferencesHelper.getData("unreadCount") ?? 0) + 1;
  //   localDataManager.preferencesHelper.saveData("unreadCount", newCount);
  // }

  // @override
  // Future<void> decreaseUnreadNotificationCount() async {
  //   int newCount =
  //       localDataManager.preferencesHelper.getData("unreadCount") - 1;
  //   localDataManager.preferencesHelper.saveData("unreadCount", newCount);
  // }
}
