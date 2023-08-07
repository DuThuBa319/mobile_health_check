import 'package:common_project/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/temperature_model.dart';
import 'temperature_api_repository.dart';

@Injectable(as: TemperatureApiRepository)
class TemperatureApiRepositoryImpl implements TemperatureApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  TemperatureApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://retoolapi.dev/SBtH5Z/temperature');

  @override
  Future<List<TemperatureModel>> getListTemperatureModels() {
    return restApi.getListTemperatureModels();
  }

  @override
  Future<TemperatureModel> getTemperatureModel({required int id}) {
    return restApi.getTemperatureModel(id: id);
  }
}
