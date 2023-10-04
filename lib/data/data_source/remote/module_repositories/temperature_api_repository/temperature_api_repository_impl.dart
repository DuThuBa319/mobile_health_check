import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/temperature_model/temperature_model.dart';
import 'temperature_api_repository.dart';

@Injectable(as: TemperatureApiRepository)
class TemperatureApiRepositoryImpl implements TemperatureApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  TemperatureApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: baseUrl);

  @override
  Future<List<TemperatureModel>> getListTemperatureModels({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return restApi.getListTemperatureModels(
      patientId: patientId,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<bool> createTemperatureModel(
      {required TemperatureModel temperatureModel, required String patientId}) {
    return restApi.createTemperatureModel(
        patientId: patientId, temperatureModel: temperatureModel);
  }
}
