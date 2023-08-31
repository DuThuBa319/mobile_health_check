// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_infor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientInforModel _$PatientInforModelFromJson(Map<String, dynamic> json) =>
    PatientInforModel(
      bloodPressures: (json['bloodPressures'] as List<dynamic>?)
          ?.map((e) => BloodPressureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bloodSugars: (json['bloodSugars'] as List<dynamic>?)
          ?.map((e) => BloodSugarModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bodyTemperatures: (json['bodyTemperatures'] as List<dynamic>?)
          ?.map((e) => TemperatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      id: json['personId'] as String,
      name: json['name'] as String,
      age: json['age'] as int?,
      personType: json['personType'] as int?,
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      phoneNumber: json['phoneNumber'] as String,
      avatarPath: json['avatar'] as String?,
      gender: json['gender'] as int?,
    );

Map<String, dynamic> _$PatientInforModelToJson(PatientInforModel instance) {
  final val = <String, dynamic>{
    'personId': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('age', instance.age);
  writeNotNull('personType', instance.personType);
  writeNotNull('weight', instance.weight);
  writeNotNull('height', instance.height);
  writeNotNull('gender', instance.gender);
  val['phoneNumber'] = instance.phoneNumber;
  writeNotNull('avatar', instance.avatarPath);
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('bodyTemperatures',
      instance.bodyTemperatures?.map((e) => e.toJson()).toList());
  writeNotNull(
      'bloodSugars', instance.bloodSugars?.map((e) => e.toJson()).toList());
  writeNotNull('bloodPressures',
      instance.bloodPressures?.map((e) => e.toJson()).toList());
  return val;
}
