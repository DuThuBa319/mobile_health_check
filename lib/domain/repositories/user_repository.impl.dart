// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_repository.dart';

@Injectable(
  as: LoginRepository,
)
class LoginRepositoryImpl extends LoginRepository {
  final UserRepository _userApi;
  LoginRepositoryImpl(
    this._userApi,
  );
  @override
  Future<List<UserModel>?> getListUserModels() {
    return _userApi.getListUserModels();
  }
}
