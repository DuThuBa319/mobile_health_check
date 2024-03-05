// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

import '../../../../data/models/doctor_infor_model/doctor_infor_model.dart';
import '../../../../data/models/patient_infor_model/patient_infor_model.dart';
import '../../../../data/models/relative_model/relative_infor_model.dart';
import '../../../../presentation/common_widget/enum_common.dart';
import 'user_model.dart';

class User extends Equatable {
  final String? currentPass;
  final int? unreadCount;
  final String? email;
  final String? id;
  final String? name;
  final String? phoneNumber;
  final UserRole? role;
  final int? age;
  final double? weight;
  final double? height;
  final int? gender;
  final String? address;
  // final int? imagesTakenToday;
  final  int? bloodPressureImagesTakenToday;
  final int? bloodSugarImagesTakenToday;
   final int? bodyTemperatureImagesTakenToday;
   final int? spO2ImagesTakenToday;
  List<PatientInforModel>? patients;
  final List<RelativeInforModel>? relatives;
  final DoctorInforModel? doctor;
  User(
      {this.currentPass,
      this.age,
      this.address,
      this.height,
      this.weight,
      this.unreadCount,
      this.email,
      this.id,
      this.name,
      this.phoneNumber,
      this.role,
      this.gender,
      this.patients,
      this.relatives,
      this.doctor,
      // this.imagesTakenToday,
       this.bloodPressureImagesTakenToday,
       this.bloodSugarImagesTakenToday,
       this.bodyTemperatureImagesTakenToday,
       this.spO2ImagesTakenToday,
      });

  @override
  List<Object?> get props => [
        // avatar,
        // createdAt
        // ,
        currentPass,
        age,
        address,
        weight,
        unreadCount,
        email,
        id,
        name,
        phoneNumber,
        role,
        gender,
        patients,
        relatives,
        doctor,
        // imagesTakenToday
         bloodPressureImagesTakenToday,
         bloodSugarImagesTakenToday,
         bodyTemperatureImagesTakenToday,
         spO2ImagesTakenToday
      ];

  UserModel convertToModel() {
    return UserModel(
        currentPass: currentPass,
        unreadCount: unreadCount,
        age: age,
        address: address,
        email: email,
        height: height,
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        role: role,
        gender: gender,
        weight: weight,
        patients: patients,
        relatives: relatives,
        doctor: doctor,
        // imagesTakenToday: imagesTakenToday
         bloodPressureImagesTakenToday:bloodPressureImagesTakenToday,
         bloodSugarImagesTakenToday:bloodSugarImagesTakenToday,
         bodyTemperatureImagesTakenToday:bodyTemperatureImagesTakenToday,
         spO2ImagesTakenToday:spO2ImagesTakenToday,
        );
  }

  User copyWith(
      {String? currentPass,
      String? currentPassword,
      int? unreadCount,
      String? email,
      String? id,
      String? name,
      String? phoneNumber,
      UserRole? role,
      int? age,
      String? address,
      double? weight,
      double? height,
      int? gender,
      int? imagesTakenToday,
       int? bloodPressureImagesTakenToday,
       int? bloodSugarImagesTakenToday,
       int? bodyTemperatureImagesTakenToday,
       int? spO2ImagesTakenToday,
      List<PatientInforModel>? patients,
      List<RelativeInforModel>? relatives,
      DoctorInforModel? doctor}) {
    return User(
      // patientInforEntity: patientInforEntity?? this.patientInforEntity,
      // imagesTakenToday: imagesTakenToday ?? this.imagesTakenToday,
      bloodPressureImagesTakenToday:bloodPressureImagesTakenToday??this.bloodPressureImagesTakenToday,
      bloodSugarImagesTakenToday:bloodSugarImagesTakenToday??this.bloodSugarImagesTakenToday,
      bodyTemperatureImagesTakenToday:bodyTemperatureImagesTakenToday?? this.bodyTemperatureImagesTakenToday,
      spO2ImagesTakenToday:spO2ImagesTakenToday?? this.spO2ImagesTakenToday,
      currentPass: currentPass ?? this.currentPass,
      unreadCount: unreadCount ?? this.unreadCount,
      age: age ?? this.age,
      address: address ?? address,
      email: email ?? this.email,
      height: height ?? this.height,
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      patients: patients ?? this.patients,
      relatives: relatives ?? this.relatives,
      doctor: doctor ?? this.doctor,
    );
  }
}
