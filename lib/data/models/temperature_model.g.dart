// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemperatureModel _$TemperatureModelFromJson(Map<String, dynamic> json) =>
    TemperatureModel(
      temperature: (json['temperature'] as num?)?.toDouble(),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$TemperatureModelToJson(TemperatureModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('temperature', instance.temperature);
  writeNotNull('updatedDate', instance.updatedDate?.toIso8601String());
  return val;
}
