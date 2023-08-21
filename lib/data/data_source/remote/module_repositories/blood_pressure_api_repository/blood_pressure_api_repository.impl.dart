import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/blood_pressure_model.dart';
import 'blood_pressure_api_repository.dart';

@Injectable(as: BloodPressureApiRepository)
class BloodPressureApiRepositoryImpl implements BloodPressureApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  BloodPressureApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl:
                'https://healthcareapplicationcloud.azurewebsites.net/api/BloodPressures');
//'https://retoolapi.dev/M5VJBr/bloodsugar
  @override
  Future<List<BloodPressureModel>> getListBloodPressureModels({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return restApi.getListBloodPressureModels(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<BloodPressureModel> getBloodPressureModel({
    required int id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return restApi.getBloodPressureModel(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<BloodPressureModel> createBloodPressureModel(
      {required BloodPressureModel bloodPressureModel}) {
    return restApi.createBloodPressureModel(
        bloodPressureModel: bloodPressureModel);
  }
}
