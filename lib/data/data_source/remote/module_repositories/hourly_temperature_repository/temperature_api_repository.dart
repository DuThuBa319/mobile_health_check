import '../../../../models/temperature_model.dart';
abstract class TemperatureApiRepository {
  Future<TemperatureModel> getTemperatureModel({
    String latitude = '10.82',
    String longitude = '106.63',
    String hourly = 'temperature_2m,relativehumidity_2m,weathercode',
    String timezone = 'Asia/Bangkok',
    String startDate=  '2023-07-14',
    String endDate = '2023-07-28',
  });
}
