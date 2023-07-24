part of 'user_detail_usecase.dart';

@Injectable(
  as: UserDetailUsecase,
)
class UserDetailUsecaseImpl extends UserDetailUsecase {
  final UserDetailRepository _repository;
  final UserDetailRepository _userdelete;
  final UserDetailRepository _userupdate;
  UserDetailUsecaseImpl(this._repository, this._userdelete, this._userupdate);

  @override
  Future<UserEntity> getUserDetailEntity(int id) async {
    final response =
        await _repository.getUserModel(id); // lấy các models từ repository

    final entity = UserEntity(
      id: response.id,
      age: response.age,
      job: response.job,
      name: response.name,
      email: response.email,
      phoneNumber: response.phoneNumber,
    );
    return entity;
  }

  @override
  Future<void> deleteUserEntity(int id) async {
    final response =
        await _userdelete.DeleteUser(id); // lấy các models từ repository
  }

  @override
  Future<void> updateUserEntity(int id, UserModel user) async {
    final response = await _userdelete.UpdateUser(id, user);
  }

  //duyệt qua từng model trong danh sách models và thêm entity tương ứng vào danh sách responseEntities. Cuối cùng, ta trả về danh sách responseEntities.
}
