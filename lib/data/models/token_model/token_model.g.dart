// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => TokenModel(
      id: json['id'] as String?,
      authToken: json['authToken'] as String?,
      expiresIn: json['expiresIn'] as int?,
    );

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('authToken', instance.authToken);
  writeNotNull('expiresIn', instance.expiresIn);
  return val;
}
