import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';
import 'package:mobile_health_check/data/models/sign_in_model/sign_in_model.dart';
import '../../../../models/doctor_infor_model/doctor_infor_model.dart';

abstract class DoctorInforApiRepository {
  Future<DoctorInforModel>? getDoctorInforModel(String? doctorId);
  Future<void> addPatientInforModel(
      String? doctorId, PatientInforModel? patientInforModel);
  Future<void> deletePatientModel(String? patientId);
 Future<void> updateDoctorInforModel(
      String? doctorId, DoctorInforModel? doctorInforModel);
  Future<void> deleteRelativeModel({String? relativeId, String? patientId});
}
