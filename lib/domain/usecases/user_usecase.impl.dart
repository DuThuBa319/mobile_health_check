part of 'user_usecase.dart';

@Injectable(
  as: UserUsecase,
)
class UserUsecaseImpl extends UserUsecase {
  final UserRepository _repository;

  UserUsecaseImpl(this._repository);
  
  @override
  Future<List<UserEntity>?> getListUserEntity() async {
    final responses = await _repository.getListUserModels();

    final responseEntities = <UserEntity>[];
    for (final response in responses) {
      final entity = UserEntity(
        id: response.id,
        age: response.age,
        job: response.job,
        name: response.name,
        email: response.email,
        phoneNumber: response.phoneNumber,
      );
      responseEntities.add(entity);
    }

    return responseEntities;
  }

  @override
  Future<UserEntity> addUserEntity(UserModel user) async {
    try {
      final response = await _repository.RegistUser(user);
      final newUser = UserEntity(
        id: response.id,
        age: response.age,
        job: response.job,
        name: response.name,
        email: response.email,
        phoneNumber: response.phoneNumber,
      );

      return newUser;
    } catch (e) {
      throw Exception('Failed to add user');
    }
  }
}
