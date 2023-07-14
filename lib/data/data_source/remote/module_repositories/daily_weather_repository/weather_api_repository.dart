import '../../../../models/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeatherModel({
    String latitude = '10.82',
    String longtitude = '106.83',
    String daily = 'weathercode',
    String timezone = 'Asia/Bangkok',
    String startDate = '2023-07-14',
    String endDate = '2023-07-28',
  });
}
