import '../../data/models/address_model/address_model.dart';
import 'patient_entity.dart';

class DoctorInforEntity {
  String id;
  String name;
  int? age;
  int? personType;
  int? gender;
  String phoneNumber;
  AddressModel? address;
  List<PatientEntity>? patients;

  DoctorInforEntity({
    required this.id,
    required this.name,
    this.age,
    this.personType,
    this.gender,
    required this.phoneNumber,
    this.address,
   required this.patients,
  });
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity