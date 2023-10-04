import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/spo2_model/spo2_model.dart';
import 'spo2_api_repository.dart';

@Injectable(as: Spo2ApiRepository)
class Spo2ApiRepositoryImpl implements Spo2ApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  Spo2ApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(
          dio,
          baseUrl: baseUrl,
        );

  @override
  Future<List<Spo2Model>> getListSpo2Models({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return restApi.getListSpo2Models(
      patientId: patientId,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<bool> createSpo2Model(
      {required Spo2Model spo2Model, required String patientId}) {
    return restApi.createSpo2Model(patientId: patientId, spo2Model: spo2Model);
  }
}
