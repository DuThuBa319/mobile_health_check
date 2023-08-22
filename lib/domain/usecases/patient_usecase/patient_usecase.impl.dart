part of 'patient_usecase.dart';

@Injectable(
  as: UserUsecase,
)
class UserUsecaseImpl extends UserUsecase {
  final UserListRepository _repository;

  UserUsecaseImpl(this._repository);

  @override
  Future<PatientInforEntity>? getPatientInforEntity(String? id) async {
    final response = await _repository.getPatientInforModel(id);
    final entity = response.getPatientInforEntity();
    return entity;
  }

  @override
  Future<List<UserEntity>?> getListUserEntity() async {
    final responses = await _repository.getListUserModels();

    final responseEntities = <UserEntity>[];
    if (responses != null) {
      for (final response in responses) {
        final entity = response.getUserEntity();
        responseEntities.add(entity);
      }
    }

    return responseEntities;
  }
  // @override
  // Future<UserEntity> addUserEntity(UserModel user) async {
  //   try {
  //     final response = await _repository.RegistUser(user);
  //     final newUser = UserEntity(
  //         id: response.id,
  //         age: response.age,
  //         name: response.name,
  //         phoneNumber: response.phoneNumber,
  //         avatarPath: response.avatarPath,
  //         height: response.height,
  //         personType: response.personType,
  //         weight: response.weight);

  //     return newUser;
  //   } catch (e) {
  //     throw Exception('Failed to add user');
  //   }
  // }
}
