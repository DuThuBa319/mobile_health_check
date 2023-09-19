import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';

import '../../../../models/account_model/account_model.dart';
import '../../../../models/doctor_infor_model/doctor_infor_model.dart';
abstract class DoctorInforApiRepository {
  Future<DoctorInforModel>? getDoctorInforModel(String? id);
  Future<AccountModel>? addPatientInforModel(
      String? id, PatientInforModel? patientInforModel);
  // Future<PatientModel> registPatient(PatientModel patient);
 Future<void> deletePatientModel(
  String? patientId);
 Future<void> deleteRelationshipDoctorAndPatientModel(
      String? doctorId, String? patientId);
  Future<void> deleteRelativeModel(
  String? relativeId);
   Future<void> deleteRelationshipRelativeAndPatientModel(
      String? relativeId, String? patientId);
}
