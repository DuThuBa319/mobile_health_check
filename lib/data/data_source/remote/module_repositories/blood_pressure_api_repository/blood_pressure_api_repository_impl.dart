import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/blood_pressure_model/blood_pressure_model.dart';
import 'blood_pressure_api_repository.dart';

@Injectable(as: BloodPressureApiRepository)
class BloodPressureApiRepositoryImpl implements BloodPressureApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  BloodPressureApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);
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
  Future<bool> createBloodPressureModel(
      {required BloodPressureModel bloodPressureModel, required String id}) {
    return restApi.createBloodPressureModel(
        id: id, bloodPressureModel: bloodPressureModel);
  }
}
