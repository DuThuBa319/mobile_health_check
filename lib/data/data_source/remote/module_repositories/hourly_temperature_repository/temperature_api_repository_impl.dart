import 'package:common_project/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/temperature_model.dart';
import 'temperature_api_repository.dart';

@Injectable(
  as: TemperatureApiRepository,
)
class TemperatureRepositoryImpl implements TemperatureApiRepository {
  final Dio dio;

  final RestApiRepository restApi;
  TemperatureRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://api.open-meteo.com/v1/forecast?latitude=10.823&longitude=106.6296&hourly=temperature_2m,relativehumidity_2m,weathercode&timezone=Asia%2FBangkok&start_date=2023-07-14&end_date=2023-07-28');

  @override
  Future<TemperatureModel> getTemperatureModel({
   String latitude = '10.82',
    String longitude = '106.63',
    String hourly = 'temperature_2m,relativehumidity_2m,weathercode',
    String timezone = 'Asia/Bangkok',
    String startDate=  '2023-07-14',
    String endDate = '2023-07-28',
  }) {
    return restApi.getTemperatureModels(
        latitude: latitude,
        longitude: longitude,
        hourly: hourly,
        timezone: timezone,
        startDate: startDate,
        endDate: endDate,
     );
  }
}
