import '../base_datasource.dart';
import 'user.dart';
import 'user_model.dart';

abstract class UserDataDataSource extends BaseDataSource {
  // Future<String?> getToken();

  // Future<void> setToken(String token);

  bool get isLogin;

  User? getUser();

  Future<void> setUser(UserModel? user);
}
