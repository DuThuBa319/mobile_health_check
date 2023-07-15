import '../../../models/user_model.dart';

abstract class UserDetailRepository {
  Future<UserModel> getUserModel(int id);
  Future<void> DeleteUser(int id);
  Future<void> UpdateUser(int id, UserModel user);
}
