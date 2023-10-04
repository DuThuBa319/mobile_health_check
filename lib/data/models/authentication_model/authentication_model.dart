import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/login_entity_group/authentication_entity.dart';


part 'authentication_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class AuthenModel {
  String? username;
  String? password;
  AuthenModel({this.username, this.password});
  factory AuthenModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenModelToJson(this);
  AuthenEntity converToAuthenInforEntity() {
    return AuthenEntity(username: username, password: password);
  }
}
