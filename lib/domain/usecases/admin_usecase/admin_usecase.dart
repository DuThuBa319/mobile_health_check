import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/common/service/local_manager/user_data_datasource/user_model.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/admin_infor_entity.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';

import '../../repositories/admin_repository/admin_repository.dart';

part 'admin_usecase.impl.dart';

abstract class AdminUsecase {
  Future<void> createDoctorAccountEntity(
      AccountEntity? accountEntity, String? adminId);
  Future<AdminInforEntity?> getAdminInforEntity({String? adminId});
  Future<void> deleteDoctorEntity(String? doctorId);
}
