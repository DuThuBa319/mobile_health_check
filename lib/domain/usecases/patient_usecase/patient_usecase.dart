import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/classes/language.dart';
import 'package:mobile_health_check/common/service/navigation/navigation_service.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';

import '../../../common/service/local_manager/user_data_datasource/user_model.dart';
import '../../../common/singletons.dart';
import '../../../di/di.dart';
import '../../entities/patient_infor_entity.dart';
import '../../repositories/patient_repository/patient_repository.dart';
part 'patient_usecase.impl.dart';

abstract class PatientUsecase {
  // Future<List<PatientEntity>?> getPatientListEntity();
  Future<PatientInforEntity?> getPatientInforEntity(String? patientId);
  Future<PatientInforEntity?> getPatientInforEntityInPatientApp(
      String? patientId);
  Future<void> updatePatientInforEntity(
      String? userId, PatientInforEntity? patientInforEntity);
  Future<void> addRelativeInforEntity(
      String? patientId, AccountEntity? accountEntity);

  // Future<PatientEntity> addPatientEntity(PatientModel Patient);
}

//Reppo chứa dữ liệu là list Patientmodel thì usecase chứa list Patiententity