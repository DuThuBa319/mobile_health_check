import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class UserModel {
  int? id;
  @JsonKey(name: 'Age')
  int? age;
  @JsonKey(name: 'Job')
  String? job;
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'Email')
  String? email;
  @JsonKey(name: 'PhoneNumber')
  String? phoneNumber;

  UserModel(
      {this.id, this.age, this.job, this.name, this.email, this.phoneNumber});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
