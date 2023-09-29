import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';
import 'package:mobile_health_check/domain/repositories/doctor_infor_repository/doctor_infor_repository.dart';

import '../../../common/service/local_manager/user_data_datasource/user_model.dart';
import '../../../common/singletons.dart';
import '../../../data/models/account_model/account_model.dart';
import '../../../data/models/relative_model/relative_infor_model.dart';
import '../../entities/account_entity.dart';
import '../../entities/doctor_infor_entity.dart';
import '../../entities/relative_infor_entity.dart';
import '../../repositories/relative_infor_repository/relative_infor_repository.dart';

part 'relative_infor_usecase.impl.dart';

abstract class RelativeInforUsecase {
  Future<RelativeInforEntity?>? getRelativeInforEntity(String? relativeId);
  Future<void> updateRelativeInforEntity(
      String? id, RelativeInforModel? patientInforModel);
}

//Reppo chứa dữ liệu là list RelativeInformodel thì usecase chứa list RelativeInforentity