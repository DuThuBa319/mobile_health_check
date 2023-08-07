part of 'temperature_usecase.dart';

@Injectable(
  as: TemperatureUsecase,
)
class TemperatureUsecaseImpl extends TemperatureUsecase {
  final TemperatureRepository _repository;

  TemperatureUsecaseImpl(this._repository);

  @override
  Future<List<TemperatureEntity>> getListTemperatureEntities() async {
    final responses = await _repository.getListTemperatureModels();

    var responseEntities = <TemperatureEntity>[];
    for (final response in responses) {
      responseEntities.add(response.getTemperatureEntity());
    }

    return responseEntities;
  }

  @override
  Future<TemperatureEntity> getTemperatureEntity({required int id}) async {
    final response = await _repository.getTemperatureModel(id: id);

    return response.getTemperatureEntity();
  }
}
