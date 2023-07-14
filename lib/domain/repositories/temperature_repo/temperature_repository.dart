import 'package:common_project/data/models/temperature_model.dart';
import 'package:injectable/injectable.dart';
import '../../../data/data_source/remote/module_repositories/hourly_temperature_repository/temperature_api_repository.dart';
part 'temperature_repository.impl.dart';

abstract class TemperatureRepository {
  Future<TemperatureModel> getTemperature({
    String latitude,
    String longitude,
    String startDate,
    String endDate,
  });
}
