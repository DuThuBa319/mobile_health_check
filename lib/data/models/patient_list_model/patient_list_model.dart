import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/patient_entity.dart';

part 'patient_list_model.g.dart';

//endpoint là các biến sẽ khai báo trong model
// còn trong thư viện retrofit thì các endpoint này còn có tên gọi là các @querry
@JsonSerializable(explicitToJson: true)
// igmnore: must_be_imutable
class PatientModel {
  @JsonKey(name:"personId")
  String id;
  String name;
  String phoneNumber;
  PatientModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);

  PatientEntity getPatientEntity() {
    return PatientEntity(
      id: id,
      name: name,
      phoneNumber: phoneNumber,    
    );
  }
}
