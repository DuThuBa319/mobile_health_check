// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_sugar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodSugarModel _$BloodSugarModelFromJson(Map<String, dynamic> json) =>
    BloodSugarModel(
      bloodSugar: (json['value'] as num?)?.toDouble(),
      updatedDate: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      imageLinkBloodSugar: json['imageLink'] as String?,
    );

Map<String, dynamic> _$BloodSugarModelToJson(BloodSugarModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.bloodSugar);
  writeNotNull('timestamp', instance.updatedDate?.toIso8601String());
  writeNotNull('imageLink', instance.imageLinkBloodSugar);
  return val;
}
