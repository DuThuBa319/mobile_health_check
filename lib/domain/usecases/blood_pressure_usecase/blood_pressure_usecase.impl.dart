part of 'blood_pressure_usecase.dart';

@Injectable(
  as: BloodPressureUsecase,
)
class BloodPressureUsecaseImpl extends BloodPressureUsecase {
  final BloodPressureRepository _repository;

  BloodPressureUsecaseImpl(this._repository);

  @override
  Future<List<BloodPressureEntity>> getListBloodPressureEntities() async {
    final responses = await _repository.getListBloodPressureModels();

    var responseEntities = <BloodPressureEntity>[];
    for (final response in responses) {
      responseEntities.add(response.getBloodPressureEntity());
    }

    return responseEntities;
  }

  @override
  Future<BloodPressureEntity> getBloodPressureEntity({required int id}) async {
    final response = await _repository.getBloodPressureModel(id: id);

    return response.getBloodPressureEntity();
  }

  @override
  Future<BloodPressureEntity> createBloodPressureEntity(
      {required BloodPressureEntity bloodPressureEntity}) async {
    final bloodPressuremodel = bloodPressureEntity.getBloodPressureModel();
    final response = await _repository.createBloodPressureModel(
        bloodPressureModel: bloodPressuremodel);

    return response.getBloodPressureEntity();
  }
}
