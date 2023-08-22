part of 'blood_sugar_usecase.dart';

@Injectable(
  as: BloodSugarUsecase,
)
class BloodSugarUsecaseImpl extends BloodSugarUsecase {
  final BloodSugarRepository _repository;

  BloodSugarUsecaseImpl(this._repository);

  @override
  Future<List<BloodSugarEntity>> getListBloodSugarEntities({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    final responses = await _repository.getListBloodSugarModels(  id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,);

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
