

import 'package:injectable/injectable.dart';

import '../../entities/patient_entity.dart';
import '../../entities/patient_infor_entity.dart';
import '../../repositories/patient_repository/patient_repository.dart';
part 'patient_usecase.impl.dart';

abstract class PatientUsecase {
  Future<List<PatientEntity>?> getPatientListEntity();
  Future<PatientInforEntity>?getPatientInforEntity(String? id);
  // Future<PatientEntity> addPatientEntity(PatientModel Patient);
}

//Reppo chứa dữ liệu là list Patientmodel thì usecase chứa list Patiententity