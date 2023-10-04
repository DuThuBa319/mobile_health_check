import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/blood_sugar_model/blood_sugar_model.dart';
import 'blood_sugar_api_repository.dart';

@Injectable(as: BloodSugarApiRepository)
class BloodSugarApiRepositoryImpl implements BloodSugarApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  BloodSugarApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(
          dio,
          baseUrl: baseUrl,
        );

  @override
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return restApi.getListBloodSugarModels(
      patientId: patientId,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  

  @override
  Future<bool> createBloodSugarModel(
      {required BloodSugarModel bloodSugarModel, required String patientId}) {
    return restApi.createBloodSugarModel(
        patientId: patientId, bloodSugarModel: bloodSugarModel);
  }
}
