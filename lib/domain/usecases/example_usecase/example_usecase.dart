import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/daily_weather_repository/weather_api_repository.dart';
import '../../entities/daily_weather_entity.dart';

part 'example_usecase.impl.dart';

abstract class ExampleUsecase {
  Future<List<DailyWeatherEntity>?> getWeatherEntity({
    String latitude,
    String longtitude,
    String startDate,
    String endDate,
  });
}
