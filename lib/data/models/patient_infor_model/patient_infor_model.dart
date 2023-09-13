import 'package:json_annotation/json_annotation.dart';

import 'package:mobile_health_check/domain/entities/blood_pressure_entity.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';

import '../../../domain/entities/blood_sugar_entity.dart';
import '../../../domain/entities/patient_infor_entity.dart';
import '../blood_pressure_model/blood_pressure_model.dart';
import '../blood_sugar_model/blood_sugar_model.dart';
import '../temperature_model/temperature_model.dart';

part 'patient_infor_model.g.dart';

//endpoint là các biến sẽ khai báo trong model
// còn trong thư viện retrofit thì các endpoint này còn có tên gọi là các @querry
@JsonSerializable(explicitToJson: true)
// igmnore: must_be_imutable
class PatientInforModel {
  @JsonKey(name: "personId")
  String id;
  String name;
  int? age;
  int? personType;
  double? weight;
  double? height;
  int? gender;
  String phoneNumber;
  @JsonKey(name: 'avatar')
  String? avatarPath;
  String? address;
  List<TemperatureModel>? bodyTemperatures;
  List<BloodSugarModel>? bloodSugars;
  List<BloodPressureModel>? bloodPressures;
  PatientInforModel({
    this.bloodPressures,
    this.bloodSugars,
    this.bodyTemperatures,
    this.address,
    required this.id,
    required this.name,
    this.age,
    this.personType,
    this.weight,
    this.height,
    required this.phoneNumber,
    this.avatarPath,
    this.gender,
  });

  factory PatientInforModel.fromJson(Map<String, dynamic> json) =>
      _$PatientInforModelFromJson(json);
  Map<String, dynamic> toJson() => _$PatientInforModelToJson(this);

  PatientInforEntity getPatientInforEntity() {
    List<BloodPressureEntity> bloodPressureEntities = [];
    if (bloodPressures != null) {
      for (var model in bloodPressures!) {
        bloodPressureEntities.add(model.getBloodPressureEntity());
      }
    }
    List<BloodSugarEntity> bloodSugarEntities = [];
    if (bloodSugars != null || bloodSugars!.isEmpty) {
      for (var model in bloodSugars!) {
        bloodSugarEntities.add(model.getBloodSugarEntity());
      }
    }
    List<TemperatureEntity> temperatureEntities = [];
    if (bodyTemperatures != null || bodyTemperatures!.isEmpty) {
      for (var model in bodyTemperatures!) {
        temperatureEntities.add(model.getTemperatureEntity());
      }
    }

    return PatientInforEntity(
      id: id,
      age: age,
      name: name,
      phoneNumber: phoneNumber,
      avatarPath: avatarPath,
      address: address,
      bloodPressures: bloodPressureEntities,
      bloodSugars: bloodSugarEntities,
      height: height,
      gender: gender == 0 ? false : true, //! Nam ==0==false
      personType: personType,
      bodyTemperatures: temperatureEntities,
      weight: weight,
    );
  }

  PatientInforEntity getPatientInforEntityPatientApp() {
    return PatientInforEntity(
      id: id,
      age: age,
      name: name,
      phoneNumber: phoneNumber,
      avatarPath: avatarPath,
      address: address,
      height: height,
      gender: gender == 0 ? false : true,
      personType: personType,
      weight: weight,
    );
  }
}
