import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/daily_weather_entity.dart';

part 'daily_weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class DailyWeatherModel {
  List<String>? time;
  @JsonKey(name: 'weathercode')
  List<int>? weatherCode;

  DailyWeatherModel(
    this.time,
    this.weatherCode,
  );

  List<DailyWeatherEntity>? getDailyWeatherEntites() {
    final result = <DailyWeatherEntity>[];
    if (time?.length != weatherCode?.length) {
      return null;
    } else {
      for (var i = 0; i < (time?.length ?? 0); i++) {
        result.add(
            DailyWeatherEntity(time: time?[i], weatherCode: weatherCode?[i]));
      }
    }
    return result;
  }

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyWeatherModelToJson(this);
}
