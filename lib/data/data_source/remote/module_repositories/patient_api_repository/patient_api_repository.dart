

import '../../../../models/patient_infor_model/patient_infor_model.dart';
import '../../../../models/patient_list_model/patient_list_model.dart';

abstract class PatientApiRepository {
  // Future<List<PatientModel>> getPatientListModels();
  Future<PatientInforModel> getPatientInforModel(String? id);
  Future<void> updatePatientInforModel(String? id, PatientInforModel? patientInforModel);

  // Future<PatientModel> registPatient(PatientModel patient);
}
