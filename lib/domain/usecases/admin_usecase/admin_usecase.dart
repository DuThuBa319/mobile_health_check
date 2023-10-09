import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';

import '../../repositories/admin_repository/admin_repository.dart';

part 'admin_usecase.impl.dart';

abstract class AdminUsecase {
  Future<void> createDoctorAccountEntity(AccountEntity? accountEntity);
  Future<List<PersonCellEntity>> getAllDoctorEntity();
  Future<void> deleteDoctorEntity(String? doctorId);

}
