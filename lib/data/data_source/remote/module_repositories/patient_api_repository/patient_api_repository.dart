import 'package:mobile_health_check/data/models/relative_model/relative_infor_model.dart';

import '../../../../models/patient_infor_model/patient_infor_model.dart';

abstract class PatientApiRepository {
  // Future<List<PatientModel>> getPatientListModels();
  Future<PatientInforModel> getPatientInforModel(String? patientId);
  Future<void> updatePatientInforModel(
      String? userId, PatientInforModel? patientInforModel);
  Future<void>? addRelativeInforModel(
      String? patientId, RelativeInforModel? relativeInforModel);
  // Future<PatientModel> registPatient(PatientModel patient);
}
