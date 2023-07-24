// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_temperature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyTemperatureModel _$HourlyTemperatureModelFromJson(
        Map<String, dynamic> json) =>
    HourlyTemperatureModel(
      time: (json['time'] as List<dynamic>?)?.map((e) => e as String).toList(),
      temperature2m: (json['temperature_2m'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      relativeHumidity2m: (json['relativehumidity_2m'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      weatherCode: (json['weathercode'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$HourlyTemperatureModelToJson(
    HourlyTemperatureModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('time', instance.time);
  writeNotNull('temperature_2m', instance.temperature2m);
  writeNotNull('relativehumidity_2m', instance.relativeHumidity2m);
  writeNotNull('weathercode', instance.weatherCode);
  return val;
}
