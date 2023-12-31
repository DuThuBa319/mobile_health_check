part of 'reset_password_usecase.dart';

@Injectable(
  as: ResetPasswordUsecase,
)
class ResetPasswordUsecaseImpl extends ResetPasswordUsecase {
  final ResetPasswordRepository _repository;

  ResetPasswordUsecaseImpl(this._repository);

  @override
  Future<void> resetPasswordEntity({String? phoneNumber}) async {
    return _repository.resetPasswordModel(phoneNumber: phoneNumber);
  }
}
