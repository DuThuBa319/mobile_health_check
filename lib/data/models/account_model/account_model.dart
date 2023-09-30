import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/account_entity.dart';

part 'account_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class AccountModel {
  String? id;

  AccountModel(
    this.id,
  );
  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  AccountEntity convertAccountEntity() {
    return AccountEntity(
      id: id,
    );
  }
}
