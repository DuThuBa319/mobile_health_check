import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/domain/repositories/doctor_infor_repository/doctor_infor_repository.dart';

import '../../../data/models/account_model/account_model.dart';
import '../../entities/account_entity.dart';
import '../../entities/doctor_infor_entity.dart';

part 'doctor_infor_usecase.impl.dart';

abstract class DoctorInforUsecase {
  Future<DoctorInforEntity?>? getDoctorInforEntity(String? id);
  Future<AccountEntity>? addPatientEntity(
      String? doctorId, PatientInforModel? patientInforModel);
  Future<void> deleteRelationshipDoctorAndPatientEntity(String? doctorId, String? patientId);
  Future<void> deletePatientEntity(String? patientId);
  Future<void> deleteRelativeEntity(String? relativeId);
  Future<void> deleteRelationshipRelativeAndPatientEntity(String? relativeId, String? patientId);

  // Future<DoctorInforEntity> addDoctorInforEntity(DoctorInforModel DoctorInfor);
}

//Reppo chứa dữ liệu là list DoctorInformodel thì usecase chứa list DoctorInforentity