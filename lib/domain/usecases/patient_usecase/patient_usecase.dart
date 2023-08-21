import 'package:mobile_health_check/domain/entities/patient_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';

import '../../repositories/patient_repository/patient_repository.dart';

part 'patient_usecase.impl.dart';

abstract class UserUsecase {
  Future<List<UserEntity>?> getListUserEntity();
  Future<PatientInforEntity>?getPatientInforEntity(String? id);
  // Future<UserEntity> addUserEntity(UserModel user);
}

//Reppo chứa dữ liệu là list usermodel thì usecase chứa list userentity