import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/daily_weather_repository/weather_api_repository.dart';
import '../../../data/models/weather_model.dart';

part 'example_repository.impl.dart';

abstract class ExampleRepository {
  Future<WeatherModel> getWeather({
    String latitude,
    String longtitude,
    String startDate,
    String endDate,
  });
}
