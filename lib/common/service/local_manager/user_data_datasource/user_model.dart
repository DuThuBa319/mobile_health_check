// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_health_check/common/service/local_manager/user_data_datasource/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  // @override
  // final String? avatar;
  // @override
  // final DateTime? createdAt;

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
  final String? role;
  @override
  final int? age;
  @override
  final double? weight;
  @override
  final double? height;
  @override
  final String? street;
  @override
  final String? ward;
  @override
  final String? district;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final bool? gender;
  // @override
  // final String? status;
  // @override
  // final DateTime? dob;

  const UserModel({
    this.age,
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
    this.gender
  }) : super(
            unreadCount: unreadCount,
            email: email,
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            role: role,
            age: age,
            city: city,
            country: country,
            district: district,
            height: height,
            street: street,
            ward: ward,
            weight: weight,
            gender: gender);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  
}
