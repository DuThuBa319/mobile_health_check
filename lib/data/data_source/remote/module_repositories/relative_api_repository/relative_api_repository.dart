import '../../../../models/relative_model/relative_infor_model.dart';

abstract class RelativeInforApiRepository {
  Future<RelativeInforModel>? getRelativeInforModel(String? relativeId);
  Future<void> updateRelativeInforModel(
      String? relativeId, RelativeInforModel? relativeInforModel);
}
