import '../../../../models/temperature_model.dart';

abstract class TemperatureApiRepository {
  Future<List<TemperatureModel>> getListTemperatureModels();
  Future<TemperatureModel> getTemperatureModel({required int id});
}
