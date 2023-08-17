// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressureModel _$BloodPressureModelFromJson(Map<String, dynamic> json) =>
    BloodPressureModel(
      dia: json['diastolic'] as int?,
      sys: json['systolic'] as int?,
      pulse: json['pulseRate'] as int?,
      imageLink: json['imageLink'] as String?,
      updatedDate: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$BloodPressureModelToJson(BloodPressureModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('systolic', instance.sys);
  writeNotNull('diastolic', instance.dia);
  writeNotNull('pulseRate', instance.pulse);
  writeNotNull('imageLink', instance.imageLink);
  writeNotNull('timestamp', instance.updatedDate?.toIso8601String());
  return val;
}
