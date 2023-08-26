

//repo này gọi đến rôp rest_api trên kia
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/data_source/remote/module_repositories/patient_api_repository/patient_api_repository.dart';

import '../../../data/models/patient_infor_model.dart';
import '../../../data/models/patient_list_model.dart';
part 'patient_repository.impl.dart';

abstract class PatientListRepository {
  Future<List<PatientModel>?> getPatientListModels();
  // Future<PatientModel> addPatientModel(PatientModel patient);
  Future<PatientInforModel> getPatientInforModel(String? id);
}
