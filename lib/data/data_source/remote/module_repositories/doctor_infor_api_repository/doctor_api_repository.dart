import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import '../../../../models/doctor_infor_model/doctor_infor_model.dart';

abstract class DoctorInforApiRepository {
  Future<DoctorInforModel>? getDoctorInforModel(String? doctorId);
  Future<void> addPatientInforModel(
      String? doctorId, AccountModel? accountModel);

  Future<void> deletePatientModel(String? patientId);
  Future<void> updateDoctorInforModel(
      String? doctorId, DoctorInforModel? doctorInforModel);
  Future<void> deleteRelativeModel({String? relativeId, String? patientId});
}
