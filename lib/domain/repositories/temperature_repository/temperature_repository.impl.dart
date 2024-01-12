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
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return temperatureApi.getListTemperatureModels(
      patientId: patientId,
      endTime: endTime,
      startTime: startTime,
    );
  }

  @override
  Future<bool> createTemperatureModel(
      {required TemperatureModel temperatureModel, required String patientId}) {
    return temperatureApi.createTemperatureModel(
        patientId: patientId, temperatureModel: temperatureModel);
  }
}

//repo này chứa một cái list<UserModel>