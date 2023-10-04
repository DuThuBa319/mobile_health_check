import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/patient_infor_model/patient_infor_model.dart';
import '../../../../models/relative_model/relative_infor_model.dart';
import '../../rest_api_repository.dart';
import 'patient_api_repository.dart';

@Injectable(as: PatientApiRepository)
class PatientApiRepositoryImpl implements PatientApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  PatientApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl:baseUrl);

  @override
  Future<PatientInforModel> getPatientInforModel(String? patientId) {
    return restApi.getPatientInforModel(patientId);
  }

  @override
  Future<void> updatePatientInforModel(
      String? userId, PatientInforModel? patientInforModel) {
    return restApi.updatePatientInforModel(userId, patientInforModel);
  }

  @override
  Future<void>? addRelativeInforModel(
      String? patientId, RelativeInforModel? relativeInforModel) {
    return restApi.addRelativeInforModel(patientId, relativeInforModel);
  }
}
