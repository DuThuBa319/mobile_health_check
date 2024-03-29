// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      currentPass: json['currentPass'] as String?,
      age: json['age'] as int?,
      address: json['address'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      unreadCount: json['unreadCount'] as int?,
      email: json['email'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
      gender: json['gender'] as int?,
      patients: (json['patients'] as List<dynamic>?)
          ?.map((e) => PatientInforModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      doctor: json['doctor'] == null
          ? null
          : DoctorInforModel.fromJson(json['doctor'] as Map<String, dynamic>),
      relatives: (json['relatives'] as List<dynamic>?)
          ?.map((e) => RelativeInforModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bloodPressureImagesTakenToday:
          json['bloodPressureImagesTakenToday'] as int?,
      bloodSugarImagesTakenToday: json['bloodSugarImagesTakenToday'] as int?,
      bodyTemperatureImagesTakenToday:
          json['bodyTemperatureImagesTakenToday'] as int?,
      spO2ImagesTakenToday: json['spO2ImagesTakenToday'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unreadCount', instance.unreadCount);
  writeNotNull('email', instance.email);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('currentPass', instance.currentPass);
  writeNotNull('role', _$UserRoleEnumMap[instance.role]);
  writeNotNull('age', instance.age);
  writeNotNull('weight', instance.weight);
  writeNotNull('height', instance.height);
  writeNotNull('address', instance.address);
  writeNotNull('gender', instance.gender);
  writeNotNull(
      'bloodPressureImagesTakenToday', instance.bloodPressureImagesTakenToday);
  writeNotNull(
      'bloodSugarImagesTakenToday', instance.bloodSugarImagesTakenToday);
  writeNotNull('bodyTemperatureImagesTakenToday',
      instance.bodyTemperatureImagesTakenToday);
  writeNotNull('spO2ImagesTakenToday', instance.spO2ImagesTakenToday);
  writeNotNull('patients', instance.patients?.map((e) => e.toJson()).toList());
  writeNotNull(
      'relatives', instance.relatives?.map((e) => e.toJson()).toList());
  writeNotNull('doctor', instance.doctor?.toJson());
  return val;
}

const _$UserRoleEnumMap = {
  UserRole.doctor: 'doctor',
  UserRole.patient: 'patient',
  UserRole.relative: 'relative',
  UserRole.admin: 'admin',
};
