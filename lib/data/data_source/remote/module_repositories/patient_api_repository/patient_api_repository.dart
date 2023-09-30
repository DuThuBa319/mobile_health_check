import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import 'package:mobile_health_check/data/models/relative_model/relative_infor_model.dart';

import '../../../../models/patient_infor_model/patient_infor_model.dart';

abstract class PatientApiRepository {
  // Future<List<PatientModel>> getPatientListModels();
  Future<PatientInforModel> getPatientInforModel(String? id);
  Future<void> updatePatientInforModel(
      String? id, PatientInforModel? patientInforModel);
  Future<AccountModel>? addRelativeInforModel(
      String? patientId, RelativeInforModel? relativeInforModel);
  // Future<PatientModel> registPatient(PatientModel patient);
}
