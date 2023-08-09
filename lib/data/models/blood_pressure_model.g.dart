// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressureModel _$BloodPressureModelFromJson(Map<String, dynamic> json) =>
    BloodPressureModel(
      dia: json['dia'] as String?,
      pulse: json['pulse'] as String?,
      sys: json['sys'] as String?,
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      id: json['id'] as int?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$BloodPressureModelToJson(BloodPressureModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('sys', instance.sys);
  writeNotNull('dia', instance.dia);
  writeNotNull('pulse', instance.pulse);
  writeNotNull('updatedDate', instance.updatedDate?.toIso8601String());
  writeNotNull('imageUrl', instance.imageUrl);
  return val;
}
