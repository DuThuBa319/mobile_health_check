import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/account_entity.dart';

part 'account_model.g.dart';

@JsonSerializable()

class AccountModel {
  //model hứng token
  String? id;
 //List<UserRole?> 
  AccountModel(
    this.id,
  );
  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  AccountEntity convertAccountEntity() {
    return AccountEntity(id: id);
  }
}
