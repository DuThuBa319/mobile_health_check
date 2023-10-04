import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_health_check/data/models/token_model/token_model.dart';

import '../../../domain/entities/login_entity_group/sign_in_entity.dart';
import '../account_model/account_model.dart';

part 'sign_in_model.g.dart';

@JsonSerializable()
class SignInModel {
  TokenModel? token;
  @JsonKey(name: 'user')
  AccountModel? accountInfor;

  List<String>? roles;

  SignInModel({this.accountInfor, this.roles, this.token});
  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInModelToJson(this);

  SignInEntity converToSignInEntity() {
    return SignInEntity(
        accountInfor: accountInfor?.converToAccountInforEntity(),
        token: token?.convertToTokenEntity(),
        roles: roles);
  }
}
