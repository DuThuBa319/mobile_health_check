import 'package:common_project/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/weather_model.dart';
import 'weather_api_repository.dart';

@Injectable(
  as: WeatherRepository,
)
class WeatherRepositoryImpl implements WeatherRepository {
  final Dio dio;

  final RestApiRepository restApi;
  WeatherRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://api.open-meteo.com/v1/forecast');

  @override
  Future<WeatherModel> getWeatherModel({
    String latitude = '10.82',
    String longtitude = '106.83',
    String daily = 'weathercode',
    String timezone = 'Asia/Bangkok',
    String startDate = '2023-01-01',
    String endDate = '2023-02-08',
  }) {
    return restApi.getWeatherModel(
        daily: daily,
        endDate: endDate,
        latitude: latitude,
        longtitude: longtitude,
        startDate: startDate,
        timezone: timezone);
  }
}
