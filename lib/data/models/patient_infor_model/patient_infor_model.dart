import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_health_check/data/models/doctor_infor_model/doctor_infor_model.dart';

import 'package:mobile_health_check/domain/entities/blood_pressure_entity.dart';
import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';
import 'package:mobile_health_check/domain/entities/relative_infor_entity.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';

import '../../../domain/entities/blood_sugar_entity.dart';
import '../../../domain/entities/patient_infor_entity.dart';
import '../../../domain/entities/spo2_entity.dart';
import '../blood_pressure_model/blood_pressure_model.dart';
import '../blood_sugar_model/blood_sugar_model.dart';
import '../relative_model/relative_infor_model.dart';
import '../spo2_model/spo2_model.dart';
import '../temperature_model/temperature_model.dart';

part 'patient_infor_model.g.dart';

//endpoint là các biến sẽ khai báo trong model
// còn trong thư viện retrofit thì các endpoint này còn có tên gọi là các @querry
@JsonSerializable(explicitToJson: true)
// igmnore: must_be_imutable
class PatientInforModel {
  String? id;
  String name;
  int? age;
  int? personType;
  double? weight;
  double? height;
  int? gender;
  String phoneNumber;
  // int? imagesTakenToday;
  int? bloodPressureImagesTakenToday;
  int? bloodSugarImagesTakenToday;
  int? bodyTemperatureImagesTakenToday;
  int? spO2ImagesTakenToday;
  String? address;
  List<RelativeInforModel>? relatives;
  DoctorInforModel? doctor;
  List<TemperatureModel>? bodyTemperatures;
  List<BloodSugarModel>? bloodSugars;
  List<BloodPressureModel>? bloodPressures;
  List<Spo2Model>? spO2s;

  PatientInforModel(
      {this.doctor,
      this.relatives,
      this.bloodPressures,
      this.bloodSugars,
      this.bodyTemperatures,
      this.spO2s,
      this.address,
      this.id,
      required this.name,
      this.age,
      this.personType,
      this.weight,
      this.height,
      required this.phoneNumber,
      this.gender,
      // this.imagesTakenToday
       this.bloodPressureImagesTakenToday,
       this.bloodSugarImagesTakenToday,
       this.bodyTemperatureImagesTakenToday,
       this.spO2ImagesTakenToday,
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
    List<Spo2Entity> spo2Entities = [];
    if (spO2s != null) {
      for (var model in spO2s!) {
        spo2Entities.add(model.getSpo2Entity());
      }
    }

    List<RelativeInforEntity> relativeEntities = [];
    if (relatives != null || relatives!.isEmpty) {
      for (var model in relatives!) {
        relativeEntities.add(model.getRelativeInforEntity());
      }
    }
    DoctorInforEntity? doctorEntity = doctor?.getDoctorEntity();
    return PatientInforEntity(
        id: id ?? "",
        age: age,
        name: name,
        phoneNumber: phoneNumber,
        address: address,
        bloodPressures: bloodPressureEntities,
        bloodSugars: bloodSugarEntities,
        height: height,
        gender: gender, //! Nam ==0==false
        personType: personType,
        bodyTemperatures: temperatureEntities,
        spo2s: spo2Entities,
        weight: weight,
        doctor: doctorEntity,
        relatives: relativeEntities,
        // imagesTakenToday: imagesTakenToday ?? 0
        bloodPressureImagesTakenToday:bloodPressureImagesTakenToday ??0,
        bloodSugarImagesTakenToday:bloodSugarImagesTakenToday??0,
        bodyTemperatureImagesTakenToday:bodyTemperatureImagesTakenToday??0,
        spO2ImagesTakenToday:spO2ImagesTakenToday??0,
        );
  }

  PatientInforEntity getPatientInforEntityForList() {
    return PatientInforEntity(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
    );
  }

//! GET PATIENT INFOR IN PATIENT APP DOESN'T GET INDICATOR OF EQUIPMENT
  PatientInforEntity getPatientInforEntityPatientApp() {
    // List<RelativeInforEntity> relativeEntities = [];
    // if (relatives != null || relatives!.isEmpty) {
    //   for (var model in relatives!) {
    //     relativeEntities.add(model.getRelativeInforEntity());
    //   }
    // }
    // DoctorInforEntity? doctorEntity = doctor?.getDoctorInforEntity();
    return PatientInforEntity(
        id: id ?? "",
        age: age,
        name: name,
        phoneNumber: phoneNumber,
        address: address,
        height: height,
        gender: gender,
        personType: personType,
        weight: weight,
        // imagesTakenToday: imagesTakenToday ?? 0
         bloodPressureImagesTakenToday:bloodPressureImagesTakenToday ??0,
         bloodSugarImagesTakenToday:bloodSugarImagesTakenToday??0,
         bodyTemperatureImagesTakenToday:bodyTemperatureImagesTakenToday??0,
         spO2ImagesTakenToday : spO2ImagesTakenToday??0
        // doctor: doctorEntity,
        // relatives: relativeEntities,
        );
  }

  PatientInforEntity addPatientEntity() {
    List<RelativeInforEntity> relativeEntities = [];
    if (relatives != null || relatives!.isEmpty) {
      for (var model in relatives!) {
        relativeEntities.add(model.getRelativeInforEntity());
      }
    }
    DoctorInforEntity? doctorEntity = doctor?.getDoctorEntity();
    return PatientInforEntity(
        id: id ?? "",
        age: age,
        name: name,
        phoneNumber: phoneNumber,
        address: address ?? "",
        height: height,
        gender: gender,
        personType: personType,
        weight: weight,
        doctor: doctorEntity,
        relatives: relativeEntities,
        // imagesTakenToday: imagesTakenToday ?? 0
         bloodPressureImagesTakenToday:bloodPressureImagesTakenToday ??0,
         bloodSugarImagesTakenToday:bloodSugarImagesTakenToday??0,
         bodyTemperatureImagesTakenToday:bodyTemperatureImagesTakenToday??0,
         spO2ImagesTakenToday: spO2ImagesTakenToday??0
        );
  }
}
