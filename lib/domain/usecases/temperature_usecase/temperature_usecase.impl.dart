part of 'temperature_usecase.dart';

@Injectable(
  as: HourlyTemperatureUsecase,
)
class HourlyTemperatureUsecaseImpl extends HourlyTemperatureUsecase {
  final TemperatureApiRepository _repository;

  HourlyTemperatureUsecaseImpl(this._repository);

  @override
  Future<List<HourlyTemperatureEntity>?> getTemperatureEntity({
    String latitude = '10.82',
    String longitude = '106.63',
    String startDate = '2023-07-14',
    String endDate = '2023-07-28',
  }) async {
    final response = await _repository.getTemperatureModel(
      latitude: latitude,
      longitude: longitude,
      startDate: startDate,
      endDate: endDate,
    );
    final hourlyTemperatureEntity =
        response.hourlyTemperatureModel?.getHourlyTemperatureEntites();
    return hourlyTemperatureEntity;
  }
}
