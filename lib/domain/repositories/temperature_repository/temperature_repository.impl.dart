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
  Future<List<TemperatureModel>> getListTemperatureModels() {
    return temperatureApi.getListTemperatureModels();
  }

  @override
  Future<TemperatureModel> getTemperatureModel({required int id}) {
    return temperatureApi.getTemperatureModel(id: id);
  }
}

//repo này chứa một cái list<UserModel>