import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';
import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/account_model/account_model.dart';
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
  Future<AccountModel>? addPatientInforModel(
      String? doctorId, PatientInforModel? patientInforModel) {
    return restApi.addPatientInforModel(doctorId, patientInforModel);
  }

  @override
  Future<void> deletePatientModel(String? patientId) {
    return restApi.deletePatient(patientId);
  }

  @override
  Future<void> deleteRelativeModel({String? relativeId, String? patientId}) {
    return restApi.deleteRelative(patientId: patientId, relativeId: relativeId);
  }

  
}
