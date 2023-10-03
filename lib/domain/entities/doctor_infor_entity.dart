import 'package:mobile_health_check/data/models/doctor_infor_model/doctor_infor_model.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';

import '../../common/service/local_manager/user_data_datasource/user.dart';

class DoctorInforEntity {
  String id;
  String name;
  int? age;
  int? personType;
  int? gender;
  String phoneNumber;
  String? address;
  List<PatientInforEntity>? patients;

  DoctorInforEntity({
    required this.id,
    required this.name,
    this.age,
    this.personType,
    this.gender,
    required this.phoneNumber,
    this.address,
    this.patients,
  });

  DoctorInforModel get convertToDoctorInforModel {
   return DoctorInforModel(
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        address: address,
        age: age,
        gender: gender,
        personType: personType);
  }
    User convertUser({required User user}) {
    return user.copyWith(
      gender: (gender == 0) ? false : true,
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      age: age,
      address: address,
    );
  }
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity