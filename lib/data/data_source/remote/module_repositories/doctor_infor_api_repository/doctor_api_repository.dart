import '../../../../models/doctor_infor_model/doctor_infor_model.dart';
abstract class DoctorInforApiRepository {
  Future<DoctorInforModel>? getDoctorInforModel(String? id);
  // Future<PatientModel> registPatient(PatientModel patient);
}
