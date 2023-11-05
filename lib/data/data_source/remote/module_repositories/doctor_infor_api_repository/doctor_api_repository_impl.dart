import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/doctor_infor_model/doctor_infor_model.dart';
import '../../rest_api_repository.dart';
import 'doctor_api_repository.dart';

@Injectable(as: DoctorInforApiRepository)
class DoctorInforApiRepositoryImpl implements DoctorInforApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  DoctorInforApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);

  @override
  Future<DoctorInforModel> getDoctorInforModel(String? doctorId) {
    return restApi.getDoctorInforModel(doctorId);
  }

  @override
  Future<void> updateDoctorInforModel(
      String? doctorId, DoctorInforModel? doctorInforModel) {
    return restApi.updateDoctorInforModel(doctorId, doctorInforModel);
  }

  @override
  Future<void> addPatientInforModel(
      String? doctorId, AccountModel? accountModel) {
    return restApi.addPatientInforModel(doctorId, accountModel);
  }

  @override
  Future<void> deletePatientModel(String? patientId) {
    return restApi.deletePatient(patientId);
  }

  @override
  Future<void> removeRelationshipRaPModel({String? relativeId, String? patientId}) {
    return restApi.removeRelationshipRaP(patientId: patientId, relativeId: relativeId);
  }
}
