import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';
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
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://healthcareapplicationcloud.azurewebsites.net');

  @override
  Future<DoctorInforModel> getDoctorInforModel(String? id) {
    return restApi.getDoctorInforModel(id);
  }

  @override
  Future<AccountModel>? addPatientInforModel(
      String? doctorId, PatientInforModel? patientInforModel) {
    return restApi.addPatientInforModel(doctorId, patientInforModel);
    // final accountModel =
    //     AccountModel(patientInforModel?.name, patientInforModel?.phoneNumber);
    // return accountModel;
  }

  @override
  Future<void> deletePatientModel(String? patientId) {
    return restApi.deletePatient(patientId);
  }

  @override
  Future<void> deleteRelativeModel(String? relativeId) {
    return restApi.deletePerson(relativeId);
  }

  @override
  Future<void> deleteRelationshipDoctorAndPatientModel(
      String? doctorId, String? patientId) {
    return restApi.deleteRelationship(doctorId, patientId);
  }

  @override
  Future<void> deleteRelationshipRelativeAndPatientModel(
      String? relativeId, String? patientId) {
    return restApi.deleteRelationship(relativeId, patientId);
  }
}
