// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spo2_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spo2Model _$Spo2ModelFromJson(Map<String, dynamic> json) => Spo2Model(
      spo2: (json['value'] as num?)?.toDouble(),
      updatedDate: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      imageLinkSpo2: json['imageLink'] as String?,
    );

Map<String, dynamic> _$Spo2ModelToJson(Spo2Model instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.spo2);
  writeNotNull('timestamp', instance.updatedDate?.toIso8601String());
  writeNotNull('imageLink', instance.imageLinkSpo2);
  return val;
}
