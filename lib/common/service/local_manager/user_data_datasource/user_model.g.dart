// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      age: json['age'] as int?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      district: json['district'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      street: json['street'] as String?,
      ward: json['ward'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      unreadCount: json['unreadCount'] as int?,
      email: json['email'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
      gender: json['gender'] as bool?,
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
  writeNotNull('street', instance.street);
  writeNotNull('ward', instance.ward);
  writeNotNull('district', instance.district);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.country);
  writeNotNull('gender', instance.gender);
  return val;
}
