// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_infor_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientInforAddressModel _$PatientInforAddressModelFromJson(
        Map<String, dynamic> json) =>
    PatientInforAddressModel(
      json['city'] as String?,
      json['country'] as String?,
      json['street'] as String?,
      json['ward'] as String?,
      json['district'] as String?,
    );

Map<String, dynamic> _$PatientInforAddressModelToJson(
    PatientInforAddressModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('street', instance.street);
  writeNotNull('ward', instance.ward);
  writeNotNull('district', instance.district);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.country);
  return val;
}
