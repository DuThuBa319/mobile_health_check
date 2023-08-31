

import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/repositories/doctor_infor_repository/doctor_infor_repository.dart';

import '../../entities/doctor_infor_entity.dart';

part 'doctor_infor_usecase.impl.dart';

abstract class DoctorInforUsecase {
  Future<DoctorInforEntity?>? getDoctorInforEntity(String? id);
  // Future<DoctorInforEntity> addDoctorInforEntity(DoctorInforModel DoctorInfor);
}

//Reppo chứa dữ liệu là list DoctorInformodel thì usecase chứa list DoctorInforentity