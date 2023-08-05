part of 'user_detail_repository.dart';

@Injectable(as: UserDetailModelRepository)
class UserDetailRepositoryImpl extends UserDetailModelRepository {
  final UserDetailRepository _userApi;

  UserDetailRepositoryImpl(this._userApi);

  @override
  Future<UserModel> getUserModel(int id) {
    return _userApi.getUserModel(id);
  }
}
