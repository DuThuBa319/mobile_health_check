import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';
import 'package:mobile_health_check/domain/repositories/doctor_infor_repository/doctor_infor_repository.dart';

import '../../../common/service/local_manager/user_data_datasource/user_model.dart';
import '../../../common/singletons.dart';
import '../../entities/account_entity.dart';
import '../../entities/doctor_infor_entity.dart';

part 'doctor_infor_usecase.impl.dart';

abstract class DoctorInforUsecase {
  Future<DoctorInforEntity?> getDoctorInforEntity(String? doctorId);
  Future<AccountEntity?> addPatientEntity(
      String? doctorId, PatientInforModel? patientInforModel);
  Future<void> deletePatientEntity(String? patientId);
  Future<void> deleteRelativeEntity(String? relativeId, String? patientId);
   Future<void> updateDoctorInforEntity(
      String? doctorId, DoctorInforEntity? doctorInforEntity);
}
