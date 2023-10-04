import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/login_entity_group/account_entity.dart';

part 'account_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class AccountModel {
  String? name;
  String? phoneNumber;
  AccountModel({this.name, this.phoneNumber});
  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
  AccountEntity converToAccountInforEntity() {
    return AccountEntity(name: name, phoneNumber: phoneNumber);
  }
}
