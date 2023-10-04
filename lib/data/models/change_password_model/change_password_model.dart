import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/change_password_entity.dart';

part 'change_password_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class ChangePassModel {
  String? newPassword;
  String? currentPassword;
  ChangePassModel({this.newPassword, this.currentPassword});
  factory ChangePassModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePassModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePassModelToJson(this);
  ChangePassEntity converToChangePassInforEntity() {
    return ChangePassEntity(
        newPassword: newPassword, currentPassword: currentPassword);
  }
}
