
import '../../../../models/temperature_model/temperature_model.dart';

abstract class TemperatureApiRepository {
  Future<List<TemperatureModel>> getListTemperatureModels({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  });
  
  Future<bool> createTemperatureModel(
      {required String id, required TemperatureModel temperatureModel});
}
