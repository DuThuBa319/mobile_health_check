import 'package:mobile_health_check/data/models/sign_in_model/sign_in_model.dart';

import '../../../../models/authentication_model/authentication_model.dart';

abstract class AuthenApiRepository {
  Future<SignInModel> signInModel(AuthenModel? authenModel);
}
