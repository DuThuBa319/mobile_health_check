// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_infor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminInforModel _$AdminInforModelFromJson(Map<String, dynamic> json) =>
    AdminInforModel(
      id: json['id'] as String,
      name: json['name'] as String,
      personType: json['personType'] as int?,
      phoneNumber: json['phoneNumber'] as String,
      doctors: (json['doctors'] as List<dynamic>?)
          ?.map((e) => PersonCellModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminInforModelToJson(AdminInforModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('personType', instance.personType);
  val['phoneNumber'] = instance.phoneNumber;
  writeNotNull('doctors', instance.doctors?.map((e) => e.toJson()).toList());
  return val;
}
