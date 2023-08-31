import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/temperature_model/temperature_model.dart';
import 'temperature_api_repository.dart';

@Injectable(as: TemperatureApiRepository)
class TemperatureApiRepositoryImpl implements TemperatureApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  TemperatureApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl:
                'https://healthcareapplicationcloud.azurewebsites.net/api/BodyTemperatures');

  @override
  Future<List<TemperatureModel>> getListTemperatureModels({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return restApi.getListTemperatureModels(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<TemperatureModel> getTemperatureModel({required int id}) {
    return restApi.getTemperatureModel(id: id);
  }

  @override
  Future<bool> createTemperatureModel(
      {required TemperatureModel temperatureModel, required String id}) {
    return restApi.createTemperatureModel(
        id: id, temperatureModel: temperatureModel);
  }
}
