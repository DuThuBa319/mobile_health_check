part of 'temperature_usecase.dart';

@Injectable(
  as: TemperatureUsecase,
)
class TemperatureUsecaseImpl extends TemperatureUsecase {
  final TemperatureRepository _repository;

  TemperatureUsecaseImpl(this._repository);

  @override
  Future<List<TemperatureEntity>> getListTemperatureEntities({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    final responses = await _repository.getListTemperatureModels(
      patientId: patientId,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );

    var responseEntities = <TemperatureEntity>[];
    for (final response in responses) {
      responseEntities.add(response.getTemperatureEntity());
    }

    return responseEntities;
  }

  @override
  Future<bool> createTemperatureEntity(
      {required String patientId,
      required TemperatureEntity temperatureEntity}) async {
    final temperaturemodel = temperatureEntity.getTemperatureModel();
    final response = await _repository.createTemperatureModel(
        patientId: patientId, temperatureModel: temperaturemodel);
    return response;
  }
}
