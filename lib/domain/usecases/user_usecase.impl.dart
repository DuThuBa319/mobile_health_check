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
      responseEntities.add(response.getUserEntity());
    }

    return responseEntities;
  }
}
