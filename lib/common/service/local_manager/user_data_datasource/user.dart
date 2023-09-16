// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'user_model.dart';

class User extends Equatable {
  //  String? avatar;
  //  DateTime? createdAt;
  final int? unreadCount;
  final String? email;
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? role;
  final int? age;
  final double? weight;
  final double? height;
  final bool? gender;
  final String? address;
  //  String? status;
  //  DateTime? dob;

  const User(
      {this.age,
      this.address,
      this.height,
      this.weight,
      this.unreadCount,
      this.email,
      this.id,
      this.name,
      this.phoneNumber,
      this.role,
      this.gender});

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
        gender
        // status,
        // dob,
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
        weight: weight);
  }

  User copyWith(
      {int? unreadCount,
      String? email,
      String? id,
      String? name,
      String? phoneNumber,
      String? role,
      int? age,
      String? address,
      double? weight,
      double? height,
      bool? gender}) {
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
    );
  }
}
