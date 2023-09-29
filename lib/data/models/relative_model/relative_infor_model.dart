import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_health_check/common/singletons.dart';

import '../../../domain/entities/patient_infor_entity.dart';
import '../../../domain/entities/relative_infor_entity.dart';
import '../patient_infor_model/patient_infor_model.dart';
// import '../../domain/entities/blood_sugar_entity.dart';
// import '../../domain/entities/Realative_infor_entity.dart';

part 'relative_infor_model.g.dart';

//endpoint là các biến sẽ khai báo trong model
// còn trong thư viện retrofit thì các endpoint này còn có tên gọi là các @querry
@JsonSerializable(explicitToJson: true)
// igmnore: must_be_imutable
class RelativeInforModel {
  @JsonKey(name: "personId")
  String? id;
  String name;
  int? age;
  int? personType;
  int? gender;
  String phoneNumber;
  String? address;
  List<PatientInforModel>? patients;
  RelativeInforModel({
    this.id,
    required this.name,
    this.age,
    this.personType,
    this.gender,
    required this.phoneNumber,
    this.address,
    this.patients,
  });

  factory RelativeInforModel.fromJson(Map<String, dynamic> json) =>
      _$RelativeInforModelFromJson(json);
  Map<String, dynamic> toJson() => _$RelativeInforModelToJson(this);

  RelativeInforEntity getRelativeInforEntity() {
    List<PatientInforEntity> patientEntities = [];
    if (patients != null) {
      for (var model in patients!) {
        patientEntities.add(model.getPatientInforEntityForList());
      }
    }
   
    return RelativeInforEntity(
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
