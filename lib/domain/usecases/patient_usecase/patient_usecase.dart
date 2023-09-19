import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/account_entity.dart';
import 'package:mobile_health_check/domain/entities/relative_infor_entity.dart';

import '../../../data/models/account_model/account_model.dart';
import '../../../data/models/patient_infor_model/patient_infor_model.dart';
import '../../../data/models/relative_model/relative_infor_model.dart';
import '../../entities/patient_infor_entity.dart';
import '../../repositories/patient_repository/patient_repository.dart';
part 'patient_usecase.impl.dart';

abstract class PatientUsecase {
  // Future<List<PatientEntity>?> getPatientListEntity();
  Future<PatientInforEntity>? getPatientInforEntity(String? id);
  Future<PatientInforEntity>? getPatientInforEntityInPatientApp(String? id);
  Future<void> updatePatientInforEntity(
      String? id, PatientInforModel? patientInforModel);
  Future<AccountEntity>? addRelativeInforEntity(
      String? patientId, RelativeInforModel? relativeInforModel);
 
  // Future<PatientEntity> addPatientEntity(PatientModel Patient);
}

//Reppo chứa dữ liệu là list Patientmodel thì usecase chứa list Patiententity