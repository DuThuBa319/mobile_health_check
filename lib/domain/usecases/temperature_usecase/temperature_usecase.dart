import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/hourly_temperature_repository/temperature_api_repository.dart';
import '../../entities/hourly_temperature_entity.dart';

part 'temperature_usecase.impl.dart';

abstract class HourlyTemperatureUsecase {
  Future<List<HourlyTemperatureEntity>?> getTemperatureEntity({
    String latitude,
    String longitude,
    String startDate,
    String endDate,
  });
}
