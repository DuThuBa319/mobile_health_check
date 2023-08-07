// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_sugar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodSugarModel _$BloodSugarModelFromJson(Map<String, dynamic> json) =>
    BloodSugarModel(
      bloodSugar: (json['bloodSugar'] as num?)?.toDouble(),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$BloodSugarModelToJson(BloodSugarModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('bloodSugar', instance.bloodSugar);
  writeNotNull('updatedDate', instance.updatedDate?.toIso8601String());
  return val;
}
