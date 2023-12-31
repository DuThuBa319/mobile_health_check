// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_infor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorInforModel _$DoctorInforModelFromJson(Map<String, dynamic> json) =>
    DoctorInforModel(
      id: json['id'] as String,
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

Map<String, dynamic> _$DoctorInforModelToJson(DoctorInforModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('age', instance.age);
  writeNotNull('personType', instance.personType);
  writeNotNull('gender', instance.gender);
  val['phoneNumber'] = instance.phoneNumber;
  writeNotNull('address', instance.address);
  writeNotNull('patients', instance.patients?.map((e) => e.toJson()).toList());
  return val;
}
