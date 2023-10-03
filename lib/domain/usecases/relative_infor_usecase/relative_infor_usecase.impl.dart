part of 'relative_infor_usecase.dart';

@Injectable(
  as: RelativeInforUsecase,
)
class RelativeInforUsecaseImpl extends RelativeInforUsecase {
  final RelativeInforRepository _repository;

  RelativeInforUsecaseImpl(this._repository);

  @override
  Future<RelativeInforEntity?> getRelativeInforEntity(
      String? relativeId) async {
    final response = await _repository.getRelativeInforModel(relativeId);
    await userDataData.setUser(UserModel(
        patients: response?.patients,
        address: response?.address ?? "chưa có thông tin",
        age: response?.age ?? 0,
        gender: response?.gender == 0 ? false : true,
        id: userDataData.getUser()!.id,
        role: userDataData.getUser()!.role,
        name: userDataData.getUser()!.name,
        phoneNumber: response?.phoneNumber,
        email: userDataData.getUser()!.email));
    final entity = response?.getRelativeInforEntity();
    return entity;
  }

  @override
  Future<void> updateRelativeInforEntity(
      String? id, RelativeInforEntity? relativeInforEntity) async {
    final relativeInforModel = relativeInforEntity?.convertToRelativeModel;
    await _repository.updateRelativeInforModel(id, relativeInforModel );
  }
}
