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
  final String? street;
  final String? ward;
  final String? district;
  final String? city;
  final String? country;
  final bool? gender;
  //  String? status;
  //  DateTime? dob;

  const User(
      {this.age,
      this.city,
      this.country,
      this.district,
      this.height,
      this.street,
      this.ward,
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
        city,
        country,
        district,
        height,
        street,
        ward,
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
        city: city,
        country: country,
        district: district,
        email: email,
        height: height,
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        role: role,
        street: street,
        ward: ward,
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
      double? weight,
      double? height,
      String? street,
      String? ward,
      String? district,
      String? city,
      String? country,
      bool? gender}) {
    return User(
      // patientInforEntity: patientInforEntity?? this.patientInforEntity,
      unreadCount: unreadCount ?? this.unreadCount,
      age: age ?? this.age,
      city: city ?? this.city,
      country: country ?? this.country,
      district: district ?? this.district,
      email: email ?? this.email,
      height: height ?? this.height,
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      street: street ?? this.street,
      ward: ward ?? this.ward,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
    );
  }
}
