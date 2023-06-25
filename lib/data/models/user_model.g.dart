// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      age: json['Age'] as int?,
      job: json['Job'] as String?,
      name: json['Name'] as String?,
      email: json['Email'] as String?,
      phoneNumber: json['PhoneNumber'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('Age', instance.age);
  writeNotNull('Job', instance.job);
  writeNotNull('Name', instance.name);
  writeNotNull('Email', instance.email);
  writeNotNull('PhoneNumber', instance.phoneNumber);
  return val;
}
