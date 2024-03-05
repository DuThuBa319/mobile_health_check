// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_infor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientInforModel _$PatientInforModelFromJson(Map<String, dynamic> json) =>
    PatientInforModel(
      doctor: json['doctor'] == null
          ? null
          : DoctorInforModel.fromJson(json['doctor'] as Map<String, dynamic>),
      relatives: (json['relatives'] as List<dynamic>?)
          ?.map((e) => RelativeInforModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bloodPressures: (json['bloodPressures'] as List<dynamic>?)
          ?.map((e) => BloodPressureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bloodSugars: (json['bloodSugars'] as List<dynamic>?)
          ?.map((e) => BloodSugarModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bodyTemperatures: (json['bodyTemperatures'] as List<dynamic>?)
          ?.map((e) => TemperatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      spO2s: (json['spO2s'] as List<dynamic>?)
          ?.map((e) => Spo2Model.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String,
      age: json['age'] as int?,
      personType: json['personType'] as int?,
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as int?,
      bloodPressureImagesTakenToday:
          json['bloodPressureImagesTakenToday'] as int?,
      bloodSugarImagesTakenToday: json['bloodSugarImagesTakenToday'] as int?,
      bodyTemperatureImagesTakenToday:
          json['bodyTemperatureImagesTakenToday'] as int?,
      spO2ImagesTakenToday: json['spO2ImagesTakenToday'] as int?,
    );

Map<String, dynamic> _$PatientInforModelToJson(PatientInforModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  writeNotNull('age', instance.age);
  writeNotNull('personType', instance.personType);
  writeNotNull('weight', instance.weight);
  writeNotNull('height', instance.height);
  writeNotNull('gender', instance.gender);
  val['phoneNumber'] = instance.phoneNumber;
  writeNotNull(
      'bloodPressureImagesTakenToday', instance.bloodPressureImagesTakenToday);
  writeNotNull(
      'bloodSugarImagesTakenToday', instance.bloodSugarImagesTakenToday);
  writeNotNull('bodyTemperatureImagesTakenToday',
      instance.bodyTemperatureImagesTakenToday);
  writeNotNull('spO2ImagesTakenToday', instance.spO2ImagesTakenToday);
  writeNotNull('address', instance.address);
  writeNotNull(
      'relatives', instance.relatives?.map((e) => e.toJson()).toList());
  writeNotNull('doctor', instance.doctor?.toJson());
  writeNotNull('bodyTemperatures',
      instance.bodyTemperatures?.map((e) => e.toJson()).toList());
  writeNotNull(
      'bloodSugars', instance.bloodSugars?.map((e) => e.toJson()).toList());
  writeNotNull('bloodPressures',
      instance.bloodPressures?.map((e) => e.toJson()).toList());
  writeNotNull('spO2s', instance.spO2s?.map((e) => e.toJson()).toList());
  return val;
}
