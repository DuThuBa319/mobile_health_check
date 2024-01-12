import 'package:injectable/injectable.dart';

import '../../../classes/language.dart';
import '../../../common/service/local_manager/user_data_datasource/user_model.dart';

import '../../../common/singletons.dart';

import '../../entities/relative_infor_entity.dart';
import '../../repositories/relative_infor_repository/relative_infor_repository.dart';

part 'relative_infor_usecase.impl.dart';

abstract class RelativeInforUsecase {
  Future<RelativeInforEntity?> getRelativeInforEntity(String? relativeId);
  Future<void> updateRelativeInforEntity(
      String? relativeId, RelativeInforEntity? relativeInforEntity);
}

//Reppo chứa dữ liệu là list RelativeInformodel thì usecase chứa list RelativeInforentity