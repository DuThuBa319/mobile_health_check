// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemperatureModel _$TemperatureModelFromJson(Map<String, dynamic> json) =>
    TemperatureModel(
      temperature: (json['value'] as num?)?.toDouble(),
      updatedDate: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      imageLinkTemperature: json['imageLink'] as String?,
    );

Map<String, dynamic> _$TemperatureModelToJson(TemperatureModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.temperature);
  writeNotNull('timestamp', instance.updatedDate?.toIso8601String());
  writeNotNull('imageLink', instance.imageLinkTemperature);
  return val;
}
