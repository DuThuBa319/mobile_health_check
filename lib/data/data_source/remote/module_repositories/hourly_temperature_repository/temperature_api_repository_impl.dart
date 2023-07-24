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
            baseUrl: 'https://api.open-meteo.com/v1/forecast');

  @override
  Future<TemperatureModel> getTemperatureModel({
    String latitude = '10.4602',
    String longitude = '105.6329',
    String hourly = 'temperature_2m,relativehumidity_2m,weathercode',
    String timezone = 'Asia/Bangkok',
    String startDate=  '2023-07-14',
    String endDate = '2023-07-28',
  }) {
    return restApi.getTemperatureModel(
        latitude: latitude,
        longitude: longitude,
        hourly: hourly,
        timezone: timezone,
        startDate: startDate,
        endDate: endDate,
     );
  }
}
