// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

import '../../../../data/models/doctor_infor_model/doctor_infor_model.dart';
import '../../../../data/models/patient_infor_model/patient_infor_model.dart';
import '../../../../data/models/relative_model/relative_infor_model.dart';
import 'user_model.dart';

class User extends Equatable {
  final int? unreadCount;
  final String? email;
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? role;
  final int? age;
  final double? weight;
  final double? height;
  final int? gender;
  final String? address;
  List<PatientInforModel>? patients;
  final List<RelativeInforModel>? relatives;
  final DoctorInforModel? doctor;
  User({
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
  });

  @override
  List<Object?> get props => [
        // avatar,
        // createdAt
        // ,
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
      ];

  UserModel convertToModel() {
    return UserModel(
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
        doctor: doctor);
  }

  User copyWith(
      {String? currentPassword,
      int? unreadCount,
      String? email,
      String? id,
      String? name,
      String? phoneNumber,
      String? role,
      int? age,
      String? address,
      double? weight,
      double? height,
      int? gender,
      List<PatientInforModel>? patients,
      List<RelativeInforModel>? relatives,
      DoctorInforModel? doctor}) {
    return User(
      // patientInforEntity: patientInforEntity?? this.patientInforEntity,
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
