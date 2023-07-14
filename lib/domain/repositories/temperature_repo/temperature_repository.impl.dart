part of 'temperature_repository.dart';

@Injectable(as: TemperatureRepository)
class TemperatureRepositoryImpl extends TemperatureRepository {

  final TemperatureApiRepository _temperatureApi;

  TemperatureRepositoryImpl(this._temperatureApi);

  @override
  Future<TemperatureModel> getTemperature({
    String latitude = '10.823',
    String longitude = '106.6296',
    String startDate = '2023-07-14',
    String endDate = '2023-07-28',
  }) {
    return _temperatureApi.getTemperatureModel(
      latitude: latitude,
      longitude: longitude,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
