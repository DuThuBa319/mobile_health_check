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
  // @override
  // final String? status;
  // @override
  // final DateTime? dob;

  const UserModel({
    this.unreadCount,
    this.email,
    this.id,
    this.name,
    this.phoneNumber,
    this.role,
  }) : super(
          unreadCount: unreadCount,
          email: email,
          id: id,
          name: name,
          phoneNumber: phoneNumber,
          role: role,
          // status: status,
          // dob: dob,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
