// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'example_repository.dart';

@Injectable(
  as: ExampleRepository,
)
class ExampleRepositoryImpl extends ExampleRepository {
  final WeatherRepository _weatherApi;
  ExampleRepositoryImpl(
    this._weatherApi,
  );
  @override
  Future<WeatherModel> getWeather({
    String latitude = '10.83',
    String longtitude = '106.83',
    String startDate = '2023-01-01',
    String endDate = '2023-02-08',
  }) {
    return _weatherApi.getWeatherModel(
      latitude: latitude,
      longtitude: longtitude,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
