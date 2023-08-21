import '../../data/models/patient_infor_address_model.dart';

class PatientInforAddressEntity {
  String? street;

  String? ward;

  String? district;

  String? city;

  String? country;

  PatientInforAddressEntity(
    this.city,
    this.country,
    this.street,
    this.ward,
    this.district,
  );

  PatientInforAddressModel getAddressModel() {
    return PatientInforAddressModel(city, country, district, street, ward);
  }
}
