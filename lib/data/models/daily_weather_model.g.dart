// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyWeatherModel _$DailyWeatherModelFromJson(Map<String, dynamic> json) =>
    DailyWeatherModel(
      (json['time'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['weathercode'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$DailyWeatherModelToJson(DailyWeatherModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('time', instance.time);
  writeNotNull('weathercode', instance.weatherCode);
  return val;
}
