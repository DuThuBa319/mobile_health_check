// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePassModel _$ChangePassModelFromJson(Map<String, dynamic> json) =>
    ChangePassModel(
      newPassword: json['newPassword'] as String?,
      currentPassword: json['currentPassword'] as String?,
    );

Map<String, dynamic> _$ChangePassModelToJson(ChangePassModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('newPassword', instance.newPassword);
  writeNotNull('currentPassword', instance.currentPassword);
  return val;
}
