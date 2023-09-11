import '../../data/models/address_model/address_model.dart';

class AddressEntity {
  String? street;

  String? ward;

  String? district;

  String? city;

  String? country;

  AddressEntity(
    this.city,
    this.country,
    this.street,
    this.ward,
    this.district,
  );

  AddressModel getAddressModel() {
    return AddressModel(city, country, district, street, ward);
  }
}
