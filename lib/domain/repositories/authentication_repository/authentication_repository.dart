//repo này gọi đến rôp rest_api trên kia

import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/sign_in_model/sign_in_model.dart';

import '../../../data/data_source/remote/module_repositories/authentication_api_repository/authentication_api_repository.dart';
import '../../../data/models/authentication_model/authentication_model.dart';
part 'authentication_repository.impl.dart';

abstract class AuthenRepository {
  Future<SignInModel> signInModel(AuthenModel? authenModel);
}
