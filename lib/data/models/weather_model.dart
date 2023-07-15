import 'package:json_annotation/json_annotation.dart';

import 'daily_weather_model.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class WeatherModel {
  @JsonKey(name: 'daily')
  DailyWeatherModel? dailyWeatherModel;
  WeatherModel(this.dailyWeatherModel);
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
