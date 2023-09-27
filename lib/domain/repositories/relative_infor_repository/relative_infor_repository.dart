//repo này gọi đến rôp rest_api trên kia

import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';

import '../../../data/data_source/remote/module_repositories/relative_api_repository/relative_api_repository.dart';
import '../../../data/models/relative_model/relative_infor_model.dart';
part 'relative_infor_repository.impl.dart';

abstract class RelativeInforRepository {
  Future<RelativeInforModel>? getRelativeInforModel(String? relativeId);
  Future<void> updateRelativeInforModel(
      String? id, RelativeInforModel? relativeInforModel);
}
