import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/login_entity_group/token_entity.dart';
part 'token_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class TokenModel {
  String? id;
  String? authToken;
  int? expiresIn;

  TokenModel({this.id, this.authToken, this.expiresIn});
  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
  TokenEntity convertToTokenEntity() {
    return TokenEntity(id: id, authToken: authToken, expiresIn: expiresIn);
  }
}
