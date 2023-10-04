// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInModel _$SignInModelFromJson(Map<String, dynamic> json) => SignInModel(
      accountInfor: json['user'] == null
          ? null
          : AccountModel.fromJson(json['user'] as Map<String, dynamic>),
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      token: json['token'] == null
          ? null
          : TokenModel.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInModelToJson(SignInModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('token', instance.token?.toJson());
  writeNotNull('user', instance.accountInfor?.toJson());
  writeNotNull('roles', instance.roles);
  return val;
}
