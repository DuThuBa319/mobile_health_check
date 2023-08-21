import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/patient_infor_address_entity.dart';
part 'patient_infor_address_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class PatientInforAddressModel {
  String? street;
  String? ward;
  String? district;
  String? city;
  String? country;
  PatientInforAddressModel(
    this.city,
    this.country,
    this.street,
    this.ward,
    this.district,
  );
  factory PatientInforAddressModel.fromJson(Map<String, dynamic> json) =>
      _$PatientInforAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInforAddressModelToJson(this);
  PatientInforAddressEntity getPatientInforAddressEntity() {
    return PatientInforAddressEntity(city, country, district, street, ward);
  }
}
