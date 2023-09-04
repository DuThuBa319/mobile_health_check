// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'user_model.dart';

class User extends Equatable {
  // final String? avatar;
  // final DateTime? createdAt;
  final String? email;
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? role;
  final int? unreadCount;
  // final String? status;
  // final DateTime? dob;

  const User(
      {
      // this.avatar,
      // this.createdAt,
      this.unreadCount,
      this.email,
      this.id,
      this.name,
      this.phoneNumber,
      this.role
      // this.status,
      // this.dob,
      });

  @override
  List<Object?> get props => [
        // avatar,
        // createdAt
        // ,
        unreadCount,
        email,
        id,
        name,
        phoneNumber,
        role
        // status,
        // dob,
      ];

  UserModel convertToModel() {
    return UserModel(
        id: id, name: name, phoneNumber: phoneNumber, email: email);
  }
}
