import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';
import 'package:mobile_health_check/domain/entities/relative_infor_entity.dart';
import 'package:mobile_health_check/domain/entities/spo2_entity.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';

import '../../common/service/local_manager/user_data_datasource/user.dart';
import 'blood_pressure_entity.dart';
import 'blood_sugar_entity.dart';

class PatientInforEntity {
  String? id;
  String name;
  int? age;
  int? personType;
  double? weight;
  double? height;
  bool? gender;
  String phoneNumber;
  String? avatarPath;
  String? address;
  List<RelativeInforEntity>? relatives;
  DoctorInforEntity? doctor;
  List<TemperatureEntity>? bodyTemperatures;
  List<BloodSugarEntity>? bloodSugars;
  List<BloodPressureEntity>? bloodPressures;
  List<Spo2Entity>? spo2s;

  PatientInforEntity({
    this.doctor,
    this.relatives,
    this.gender,
    this.bloodPressures,
    this.bloodSugars,
    this.bodyTemperatures,
    this.spo2s,
    this.address,
    this.id,
    required this.name,
    this.age,
    this.personType,
    this.weight,
    this.height,
    required this.phoneNumber,
    this.avatarPath,
  });

  User convertUser({required User user}) {
    return user.copyWith(
      gender: gender,
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      age: age,
      address: address,
      height: height,
      weight: weight,
    );
  }
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity