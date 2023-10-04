// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenModel _$AuthenModelFromJson(Map<String, dynamic> json) => AuthenModel(
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AuthenModelToJson(AuthenModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('username', instance.username);
  writeNotNull('password', instance.password);
  return val;
}
