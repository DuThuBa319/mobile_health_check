import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../singletons.dart';
import '../base_datasource.dart';

import 'user.dart';
import 'user_data_datasource.dart';
import 'user_model.dart';

@Injectable(
  as: UserDataDataSource,
)
class UserDataDataSourceImpl extends BaseDataSource
    implements UserDataDataSource {
  @override
  Future<void> clearData() async {
    await localDataManager.secureStorage.deleteAll();
    await localDataManager.preferencesHelper.remove('user');
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
  bool get isLogin => firebaseAuthService.isSignedIn;

  @override
  User? getUser() {
    final data = localDataManager.preferencesHelper.getData("user") as String?;
    if (data == null || data == '' || data == 'null') {
      return null;
    }
    return UserModel.fromJson(
      jsonDecode(data) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> setUser(UserModel? user) async {
    final jsonObj = jsonEncode(user?.toJson());
    localDataManager.preferencesHelper.saveData("user", jsonObj);
  }
}
