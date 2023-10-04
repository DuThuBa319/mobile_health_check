part of 'authentication_usecase.dart';

@Injectable(
  as: AuthenUsecase,
)
class AuthenUsecaseImpl extends AuthenUsecase {
  final AuthenRepository _repository;

  AuthenUsecaseImpl(this._repository);

  @override
  Future<SignInEntity> signInAuthenEntity(AuthenEntity? authenEntity) async {
    final model =
        await _repository.signInModel(authenEntity?.convertToAuthenModel);
    return model.converToSignInEntity();
  }
}
