part of 'blood_sugar_usecase.dart';

@Injectable(
  as: BloodSugarUsecase,
)
class BloodSugarUsecaseImpl extends BloodSugarUsecase {
  final BloodSugarRepository _repository;

  BloodSugarUsecaseImpl(this._repository);

  @override
  Future<List<BloodSugarEntity>> getListBloodSugarEntities({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    final responses = await _repository.getListBloodSugarModels(
      patientId: patientId,
      endTime: endTime ,
      startTime: startTime ,
    );
    var responseEntities = <BloodSugarEntity>[];
    for (final response in responses) {
      responseEntities.add(response.getBloodSugarEntity());
    }

    return responseEntities;
  }

  @override
  Future<bool> createBloodSugarEntity(
      {required String patientId, required BloodSugarEntity bloodSugarEntity}) async {
    final bloodSugarmodel = bloodSugarEntity.getBloodSugarModel();
    final response = await _repository.createBloodSugarModel(
        patientId: patientId, bloodSugarModel: bloodSugarmodel);

    return response;
  }
}
