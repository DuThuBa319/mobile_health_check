part of 'blood_pressure_usecase.dart';

@Injectable(
  as: BloodPressureUsecase,
)
class BloodPressureUsecaseImpl extends BloodPressureUsecase {
  final BloodPressureRepository _repository;

  BloodPressureUsecaseImpl(this._repository);

  @override
  Future<List<BloodPressureEntity>> getListBloodPressureEntities({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    final responses = await _repository.getListBloodPressureModels(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
    var responseEntities = <BloodPressureEntity>[];
    for (final response in responses) {
      responseEntities.add(response.getBloodPressureEntity());
      print(response);
    }

    return responseEntities;
  }

  @override
  Future<BloodPressureEntity> getBloodPressureEntity({
    required int id,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    final response = await _repository.getBloodPressureModel(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );

    return response.getBloodPressureEntity();
  }

  @override
  Future<bool> createBloodPressureEntity(
      {required String id,
      required BloodPressureEntity bloodPressureEntity}) async {
    final bloodPressuremodel = bloodPressureEntity.getBloodPressureModel();
    final response = await _repository.createBloodPressureModel(
        id: id, bloodPressureModel: bloodPressuremodel);

    return response;
  }
}
