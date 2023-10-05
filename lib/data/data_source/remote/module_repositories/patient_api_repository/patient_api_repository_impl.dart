import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/account_model/account_model.dart';

import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/patient_infor_model/patient_infor_model.dart';
import '../../rest_api_repository.dart';
import 'patient_api_repository.dart';

@Injectable(as: PatientApiRepository)
class PatientApiRepositoryImpl implements PatientApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  PatientApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);

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
  Future<void> addRelativeInforModel(
      String? patientId, AccountModel? accountModel) {
    return restApi.addRelativeInforModel(patientId, accountModel);
  }
}
