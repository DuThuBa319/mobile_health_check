import 'package:mobile_health_check/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

//endpoint là các biến sẽ khai báo trong model
// còn trong thư viện retrofit thì các endpoint này còn có tên gọi là các @querry
@JsonSerializable(explicitToJson: true)
// igmnore: must_be_imutable
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
  // Sau khi tới bước Entity mới làm cái này
  UserEntity getUserEntity() {
    return UserEntity(
        id: id,
        age: age,
        job: job,
        name: name,
        email: email,
        phoneNumber: phoneNumber);
  }
}
