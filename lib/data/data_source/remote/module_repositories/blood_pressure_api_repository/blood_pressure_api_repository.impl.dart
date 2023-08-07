import 'package:common_project/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/blood_pressure_model.dart';
import 'blood_pressure_api_repository.dart';

@Injectable(as: BloodPressureApiRepository)
class BloodPressureApiRepositoryImpl implements BloodPressureApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  BloodPressureApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://retoolapi.dev/XUw274/data');

  @override
  Future<List<BloodPressureModel>> getListBloodPressureModels() {
    return restApi.getListBloodPressureModels();
  }

  @override
  Future<BloodPressureModel> getBloodPressureModel({required int id}) {
    return restApi.getBloodPressureModel(id: id);
  }

  @override
  Future<BloodPressureModel> createBloodPressureModel(
      {required BloodPressureModel bloodPressureModel}) {
    return restApi.createBloodPressureModel(
        bloodPressureModel: bloodPressureModel);
  }
}
