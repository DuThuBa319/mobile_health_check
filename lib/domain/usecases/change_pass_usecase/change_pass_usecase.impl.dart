part of 'change_pass_usecase.dart';

@Injectable(
  as: ChangePassUsecase,
)
class ChangePassUsecaseImpl extends ChangePassUsecase {
  final ChangePassRepository _repository;

  ChangePassUsecaseImpl(this._repository);

  @override
  Future<void> changePassEntity(
      ChangePassEntity? changePassEntity, String? userId) async {
    return _repository.changePassModel(changePassEntity?.convertToChangePassModel, userId);
  }
}
