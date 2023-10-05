import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/domain/repositories/doctor_infor_repository/doctor_infor_repository.dart';

import '../../../common/service/local_manager/user_data_datasource/user_model.dart';
import '../../../common/singletons.dart';
import '../../entities/doctor_infor_entity.dart';

part 'doctor_infor_usecase.impl.dart';

abstract class DoctorInforUsecase {
  Future<DoctorInforEntity?> getDoctorInforEntity(String? doctorId);
  Future<void> addPatientEntity(String? doctorId, AccountEntity? accountEntity);
  Future<void> deletePatientEntity(String? patientId);
  Future<void> deleteRelativeEntity(String? relativeId, String? patientId);
  Future<void> updateDoctorInforEntity(
      String? doctorId, DoctorInforEntity? doctorInforEntity);
}
