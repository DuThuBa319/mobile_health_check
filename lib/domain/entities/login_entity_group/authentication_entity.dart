import 'package:mobile_health_check/data/models/authentication_model/authentication_model.dart';

class AuthenEntity {
  String? username;
  String? password;
  AuthenEntity({this.username, this.password});

  AuthenModel get convertToAuthenModel {
    return AuthenModel(password: password, username: username);
  }
}
