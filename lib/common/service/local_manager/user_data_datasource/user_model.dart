// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, overridden_fields
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_health_check/common/service/local_manager/user_data_datasource/user.dart';
import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';
import 'package:mobile_health_check/data/models/relative_model/relative_infor_model.dart';

import '../../../../data/models/doctor_infor_model/doctor_infor_model.dart';
import '../../../../presentation/common_widget/enum_common.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends User {
  @override
  final int? unreadCount;
  @override
  final String? email;
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? phoneNumber;

  @override
  final String? currentPass;

  @override
  final UserRole? role;
  @override
  final int? age;
  @override
  final double? weight;
  @override
  final double? height;
  @override
  final String? address;
  @override
  final int? gender;
  @override
  final List<PatientInforModel>? patients;
  @override
  final List<RelativeInforModel>? relatives;
  @override
  final DoctorInforModel? doctor;
  UserModel(
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
      this.doctor,
      this.relatives})
      : super(
            currentPass: currentPass,
            unreadCount: unreadCount,
            email: email,
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            role: role,
            age: age,
            address: address,
            height: height,
            weight: weight,
            gender: gender,
            patients: patients,
            doctor: doctor,
            relatives: relatives);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
