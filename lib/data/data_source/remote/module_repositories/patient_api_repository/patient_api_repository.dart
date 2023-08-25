import '../../../../models/patient_infor_model.dart';
import '../../../../models/patient_list_model.dart';

abstract class PatientApiRepository {
  Future<List<PatientModel>> getPatientListModels();
  Future<PatientInforModel> getPatientInforModel(String? id);
  // Future<PatientModel> registPatient(PatientModel patient);
}
