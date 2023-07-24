import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/hourly_temperature_entity.dart';

// import '../../domain/entities/hourly_temperature_entity.dart';

part 'hourly_temperature_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HourlyTemperatureModel {
  List<String>? time;
  @JsonKey(name: 'temperature_2m')
  List<double>? temperature2m;
  @JsonKey(name: 'relativehumidity_2m')
  List<int>? relativeHumidity2m;
  @JsonKey(name: 'weathercode')
  List<int>? weatherCode;

  HourlyTemperatureModel({
    this.time,
    this.temperature2m,
    this.relativeHumidity2m,
    this.weatherCode,
  });

  List<HourlyTemperatureEntity> getHourlyTemperatureEntites() {
    final result = <HourlyTemperatureEntity>[];
    if (time?.length != weatherCode?.length) {
      return result;
    } else {
      for (var i = 0; i < (time?.length ?? 0); i++) {
        result.add(
          HourlyTemperatureEntity(
            time: time?[i],
            temperature2m: temperature2m?[i],
            relativeHumidity2m: relativeHumidity2m?[i],
            weatherCode: weatherCode?[i],
          ),
        );
      }
    }
    return result;
  }

  factory HourlyTemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyTemperatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyTemperatureModelToJson(this);
}
