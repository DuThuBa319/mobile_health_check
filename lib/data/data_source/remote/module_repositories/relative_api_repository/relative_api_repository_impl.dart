import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/relative_model/relative_infor_model.dart';
import '../../rest_api_repository.dart';
import 'relative_api_repository.dart';

@Injectable(as: RelativeInforApiRepository)
class RelativeInforApiRepositoryImpl implements RelativeInforApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  RelativeInforApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);

  @override
  Future<RelativeInforModel> getRelativeInforModel(String? relativeId) {
    return restApi.getRelativeInforModel(relativeId: relativeId);
  }

  @override
  Future<void> updateRelativeInforModel(
      String? relativeId, RelativeInforModel? relativeInforModel) {
    return restApi.updateRelativeInforModel(
        relativeId: relativeId, relativeInforModel: relativeInforModel);
  }
}
