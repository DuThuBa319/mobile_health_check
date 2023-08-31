import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/patient_infor_address_entity.dart';
part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class AddressModel {
  String? street;
  String? ward;
  String? district;
  String? city;
  String? country;
  AddressModel(
    this.city,
    this.country,
    this.street,
    this.ward,
    this.district,
  );
  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
  AddressEntity getAddressEntity() {
    return AddressEntity(city, country, district, street, ward);
  }
}
