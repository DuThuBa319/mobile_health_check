import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/doctor_infor_entity.dart';
import '../../../domain/entities/patient_infor_entity.dart';
import '../patient_infor_model/patient_infor_model.dart';
// import '../../domain/entities/blood_sugar_entity.dart';
// import '../../domain/entities/Doctor_infor_entity.dart';

part 'doctor_infor_model.g.dart';

//endpoint là các biến sẽ khai báo trong model
// còn trong thư viện retrofit thì các endpoint này còn có tên gọi là các @querry
@JsonSerializable(explicitToJson: true)
// igmnore: must_be_imutable
class DoctorInforModel {
  @JsonKey(name: "personId")
  String id;
  String name;
  int? age;
  int? personType;
  int? gender;
  String phoneNumber;
  String? address;
  List<PatientInforModel>? patients;
  DoctorInforModel({
    required this.id,
    required this.name,
    this.age,
    this.personType,
    this.gender,
    required this.phoneNumber,
    this.address,
    this.patients,
  });

  factory DoctorInforModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorInforModelFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorInforModelToJson(this);

  DoctorInforEntity getDoctorInforEntity() {
    List<PatientInforEntity> patientEntities = [];
    if (patients != null) {
      for (var model in patients!) {
        patientEntities.add(model.getPatientInforEntityForList());
      }
    }
    return DoctorInforEntity(
      id: id,
      name: name,
      age: age,
      personType: personType,
      gender: gender,
      phoneNumber: phoneNumber,
      address: address,
      patients: patientEntities,
    );
  }
}
