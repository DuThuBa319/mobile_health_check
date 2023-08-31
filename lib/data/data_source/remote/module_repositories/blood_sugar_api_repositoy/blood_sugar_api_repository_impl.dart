import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/blood_sugar_model/blood_sugar_model.dart';
import 'blood_sugar_api_repository.dart';

@Injectable(as: BloodSugarApiRepository)
class BloodSugarApiRepositoryImpl implements BloodSugarApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  BloodSugarApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(
          dio,
          baseUrl:
              'https://healthcareapplicationcloud.azurewebsites.net/api/BloodSugars',
        );

  @override
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return restApi.getListBloodSugarModels(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<BloodSugarModel> getBloodSugarModel({required int id}) {
    return restApi.getBloodSugarModel(id: id);
  }

  @override
  Future<bool> createBloodSugarModel(
      {required BloodSugarModel bloodSugarModel, required String id}) {
    return restApi.createBloodSugarModel(
        id: id, bloodSugarModel: bloodSugarModel);
  }
}