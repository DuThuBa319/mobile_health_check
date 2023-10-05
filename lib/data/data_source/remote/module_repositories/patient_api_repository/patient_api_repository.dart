import 'package:mobile_health_check/data/models/account_model/account_model.dart';

import '../../../../models/patient_infor_model/patient_infor_model.dart';

abstract class PatientApiRepository {
  // Future<List<PatientModel>> getPatientListModels();
  Future<PatientInforModel> getPatientInforModel(String? patientId);
  Future<void> updatePatientInforModel(
      String? userId, PatientInforModel? patientInforModel);
  Future<void> addRelativeInforModel(
      String? patientId, AccountModel? accountModel);
  // Future<PatientModel> registPatient(PatientModel patient);
}
