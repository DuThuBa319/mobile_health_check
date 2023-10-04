// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_pass_repository.dart';

@Injectable(
  as: ChangePassRepository,
)
class ChangePassRepositoryImpl extends ChangePassRepository {
  final ChangePassApiRepository _changePassApi;

  ChangePassRepositoryImpl(
    this._changePassApi,
  );
  @override
  Future<void> changePassModel(
      ChangePassModel? changePassModel, String? userId) {
    return _changePassApi.changePassModel(userId, changePassModel);
  }
}
