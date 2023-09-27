import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../models/relative_model/relative_infor_model.dart';
import '../../rest_api_repository.dart';
import 'relative_api_repository.dart';

@Injectable(as: RelativeInforApiRepository)
class RelativeInforApiRepositoryImpl implements RelativeInforApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  RelativeInforApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://healthcareapplicationcloud.azurewebsites.net');

  @override
  Future<RelativeInforModel> getRelativeInforModel(String? relativeId) {
    return restApi.getRelativeInforModel(relativeId);
  }
    @override
  Future<void> updateRelativeInforModel(
      String? id, RelativeInforModel? relativeInforModel) {
    return restApi.updateRelativeInforModel(id, relativeInforModel);
  }
}
