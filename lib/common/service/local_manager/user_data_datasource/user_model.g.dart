// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      age: json['age'] as int?,
      address: json['address'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      unreadCount: json['unreadCount'] as int?,
      email: json['email'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
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
  writeNotNull('role', instance.role);
  writeNotNull('age', instance.age);
  writeNotNull('weight', instance.weight);
  writeNotNull('height', instance.height);
  writeNotNull('address', instance.address);
  writeNotNull('gender', instance.gender);
  writeNotNull('patients', instance.patients?.map((e) => e.toJson()).toList());
  writeNotNull(
      'relatives', instance.relatives?.map((e) => e.toJson()).toList());
  writeNotNull('doctor', instance.doctor?.toJson());
  return val;
}
