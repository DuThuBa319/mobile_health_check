// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relative_infor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelativeInforModel _$RelativeInforModelFromJson(Map<String, dynamic> json) =>
    RelativeInforModel(
      id: json['personId'] as String?,
      name: json['name'] as String,
      age: json['age'] as int?,
      personType: json['personType'] as int?,
      gender: json['gender'] as int?,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String?,
      patients: (json['patients'] as List<dynamic>?)
          ?.map((e) => PatientInforModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RelativeInforModelToJson(RelativeInforModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('personId', instance.id);
  val['name'] = instance.name;
  writeNotNull('age', instance.age);
  writeNotNull('personType', instance.personType);
  writeNotNull('gender', instance.gender);
  val['phoneNumber'] = instance.phoneNumber;
  writeNotNull('address', instance.address);
  writeNotNull('patients', instance.patients?.map((e) => e.toJson()).toList());
  return val;
}
