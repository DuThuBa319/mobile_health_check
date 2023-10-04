// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_repository.dart';

@Injectable(
  as: AuthenRepository,
)
class AuthenRepositoryImpl extends AuthenRepository {
  final AuthenApiRepository _authenInforApi;

  AuthenRepositoryImpl(
    this._authenInforApi,
  );
  @override
  Future<SignInModel> signInModel(AuthenModel? authenModel) {
    
    return _authenInforApi.signInModel(authenModel);
  }
 
}
