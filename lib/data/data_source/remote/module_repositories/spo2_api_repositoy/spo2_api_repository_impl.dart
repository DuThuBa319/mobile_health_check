import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/blood_sugar_model/blood_sugar_model.dart';
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
          baseUrl:
              'https://healthcareapplicationcloud.azurewebsites.net/api/SpO2s',
        );

  @override
  Future<List<Spo2Model>> getListSpo2Models({
  required String? id,
  DateTime? startTime,
  DateTime? endTime,
   }) {
   return restApi.getListSpo2Models(
     id: id,
     endTime: endTime ?? endTime!,
     startTime: startTime ?? startTime!,
   );
   }

   @override
   Future<Spo2Model> getSpo2Model({required int id}) {
   return restApi.getSpo2Model(id: id);
   }

   @override
   Future<bool> createSpo2Model(
   {required Spo2Model spo2Model, required String id}) {
   return restApi.createSpo2Model(
   id: id, spo2Model: spo2Model);
  }
}
