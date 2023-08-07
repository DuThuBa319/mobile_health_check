part of 'blood_sugar_usecase.dart';

@Injectable(
  as: BloodSugarUsecase,
)
class BloodSugarUsecaseImpl extends BloodSugarUsecase {
  final BloodSugarRepository _repository;

  BloodSugarUsecaseImpl(this._repository);

  @override
  Future<List<BloodSugarEntity>> getListBloodSugarEntities() async {
    final responses = await _repository.getListBloodSugarModels();

    var responseEntities = <BloodSugarEntity>[];
    for (final response in responses) {
      responseEntities.add(response.getBloodSugarEntity());
    }

    return responseEntities;
  }

  @override
  Future<BloodSugarEntity> getBloodSugarEntity({required int id}) async {
    final response = await _repository.getBloodSugarModel(id: id);

    return response.getBloodSugarEntity();
  }
}
