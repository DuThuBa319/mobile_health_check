import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/temperature_api_repository/temperature_api_repository.dart';
import '../../../data/models/temperature_model.dart';

part 'temperature_repository.impl.dart';

//repo này gọi đến rôp rest_api trên kia
abstract class TemperatureRepository {
  Future<List<TemperatureModel>> getListTemperatureModels({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  });
  Future<TemperatureModel> getTemperatureModel({required int id});
  Future<bool> createTemperatureModel(
      {required String id, required TemperatureModel temperatureModel});
}
