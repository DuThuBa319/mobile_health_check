// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['personId'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'personId': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
    };
