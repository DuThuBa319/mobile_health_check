// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'temperature_repository.dart';

@Injectable(
  as: TemperatureRepository,
)
class TemperatureRepositoryImpl extends TemperatureRepository {
  final TemperatureApiRepository temperatureApi;
  TemperatureRepositoryImpl(
    this.temperatureApi,
  );
  @override
  Future<List<TemperatureModel>> getListTemperatureModels({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return temperatureApi.getListTemperatureModels(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<TemperatureModel> getTemperatureModel({required int id}) {
    return temperatureApi.getTemperatureModel(id: id);
  }

  @override
  Future<bool> createTemperatureModel(
      {required TemperatureModel temperatureModel, required String id}) {
    return temperatureApi.createTemperatureModel(
        id: id, temperatureModel: temperatureModel);
  }
}

//repo này chứa một cái list<UserModel>