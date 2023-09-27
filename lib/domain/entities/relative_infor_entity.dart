import 'package:mobile_health_check/data/models/relative_model/relative_infor_model.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';

import '../../common/service/local_manager/user_data_datasource/user.dart';

class RelativeInforEntity {
  String? id;
  String name;
  int? age;
  int? personType;
  int? gender;
  String phoneNumber;
  String? address;
  List<PatientInforEntity>? patients;

  RelativeInforEntity({
    this.id,
    required this.name,
    this.age,
    this.personType,
    this.gender,
    required this.phoneNumber,
    this.address,
    required this.patients,
  });
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

  // RelativeInforModel convertToRelativeModel() {
  //   final model = RelativeInforModel(
  //       name: name,
  //       phoneNumber: phoneNumber,
  //       address: address,
  //       age: age,
  //       gender: gender,
  //       id: id,
  //       patients: patients,
  //       personType: 2);
  //   return model;
  // }
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity