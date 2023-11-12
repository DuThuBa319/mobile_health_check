// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reset_password_repository.dart';

@Injectable(
  as: ResetPasswordRepository,
)
class ResetPasswordRepositoryImpl extends ResetPasswordRepository {
  final ResetPasswordApiRepository _authenInforApi;

  ResetPasswordRepositoryImpl(
    this._authenInforApi,
  );
  @override
  Future<void> resetPasswordModel({String? phoneNumber}) {
    return _authenInforApi.resetPasswordModel(phoneNumber: phoneNumber);
  }
}
