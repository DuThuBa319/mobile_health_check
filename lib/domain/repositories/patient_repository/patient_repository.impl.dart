// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'patient_repository.dart';

@Injectable(
  as: UserListRepository,
)
class UserListRepositoryImpl extends UserListRepository {
  final UserApiRepository _userApi;
  UserListRepositoryImpl(
    this._userApi,
  );
  @override
  Future<List<UserModel>?> getListUserModels() {
    return _userApi.getListUserModels();
  }

  @override
  Future<UserModel> AddUserModel(UserModel user) {
    return _userApi.RegistUser(user);
  }

  @override
  Future<PatientInforModel> getPatientInforModel(String? id) {
    return _userApi.getPatientInforModel(id);
  }
}

//repo này chứa một cái list<UserModel>