import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/patient_entity.dart';

part 'patient_list_model.g.dart';

//endpoint là các biến sẽ khai báo trong model
// còn trong thư viện retrofit thì các endpoint này còn có tên gọi là các @querry
@JsonSerializable(explicitToJson: true)
// igmnore: must_be_imutable
class PatientModel {
  @JsonKey(name: "personId")
  String id;
  String name;
  // int? age;
  // int? personType;
  // double? weight;
  // double? height;
  String phoneNumber;
  // @JsonKey(name: 'avatar')
  // String? avatarPath;
  // PatientAddressModel? address;
  // List<TemperatureModel>? bodyTemperatures;
  // List<BloodSugarModel>? bloodSugars;
  // List<BloodPressureModel>? bloodPressures;
  PatientModel({
    // this.bloodPressures,
    // this.bloodSugars,
    // this.bodyTemperatures,
    // this.address,
    required this.id,
    required this.name,
    // this.age,
    // this.personType,
    // this.weight,
    // this.height,
    required this.phoneNumber,
    // this.avatarPath,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);

  PatientEntity getPatientEntity() {
    // List<BloodPressureEntity> bloodPressureEntities = [];
    // if (bloodPressures != null) {
    //   for (var model in bloodPressures!) {
    //     bloodPressureEntities.add(model.getBloodPressureEntity());
    //   }
    //   if (bloodPressures!.isEmpty) {
    //     for (var model in bloodPressures!) {
    //       bloodPressureEntities.add(model.getBloodPressureEntity());
    //     }
    //   }
    // }
    // List<BloodSugarEntity> bloodSugarEntities = [];
    // if (bloodSugars != null || bloodSugars!.isEmpty) {
    //   for (var model in bloodSugars!) {
    //     bloodSugarEntities.add(model.getBloodSugarEntity());
    //   }
    // }
    // List<TemperatureEntity> temperatureEntities = [];
    // if (bodyTemperatures != null || bodyTemperatures!.isEmpty) {
    //   for (var model in bodyTemperatures!) {
    //     temperatureEntities.add(model.getTemperatureEntity());
    //   }
    // }

    return PatientEntity(
      id: id,
      // age: age,
      name: name,
      phoneNumber: phoneNumber,
      // avatarPath: avatarPath,
      // address: address,
      // bloodPressures: bloodPressureEntities,
      // bloodSugars: bloodSugarEntities,
      // height: height,
      // personType: personType,
      // bodyTemperatures: temperatureEntities,
      // weight: weight,
    );
  }
}
