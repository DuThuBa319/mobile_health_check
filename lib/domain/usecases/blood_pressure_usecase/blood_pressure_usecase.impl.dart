part of 'blood_pressure_usecase.dart';

@Injectable(
  as: BloodPressureUsecase,
)
class BloodPressureUsecaseImpl extends BloodPressureUsecase {
  final BloodPressureRepository _repository;

  BloodPressureUsecaseImpl(this._repository);

  @override
  Future<List<BloodPressureEntity>> getListBloodPressureEntities({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    final responses = await _repository.getListBloodPressureModels(
      patientId: patientId,
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
  Future<bool> createBloodPressureEntity(
      {required String patientId,
      required BloodPressureEntity bloodPressureEntity}) async {
    final bloodPressuremodel = bloodPressureEntity.convertToModel;
    final response = await _repository.createBloodPressureModel(
        patientId: patientId, bloodPressureModel: bloodPressuremodel);

    return response;
  }
}
