import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_health_check/data/models/token_model/token_model.dart';

import '../../../domain/entities/login_entity_group/sign_in_entity.dart';
import '../../../presentation/common_widget/enum_common.dart';
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
    const map = {
      'doctor': UserRole.doctor,
      'admin': UserRole.admin,
      'patient': UserRole.patient,
      'relative': UserRole.relative
    };

    return SignInEntity(
        accountInfor: accountInfor?.converToAccountInforEntity(),
        token: token?.convertToTokenEntity(),
        role: map[roles?[0]]);
  }
}
