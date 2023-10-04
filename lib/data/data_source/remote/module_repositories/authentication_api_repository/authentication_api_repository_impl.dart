import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/authentication_model/authentication_model.dart';
import 'package:mobile_health_check/data/models/sign_in_model/sign_in_model.dart';

import '../../../../../presentation/common_widget/enum_common.dart';

import '../../rest_api_repository.dart';
import 'authentication_api_repository.dart';

@Injectable(as: AuthenApiRepository)
class AuthenApiRepositoryImpl implements AuthenApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  AuthenApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);

  @override
  Future<SignInModel> signInModel(AuthenModel? authenModel) {
    return restApi.signIn(authenModel);
  }
}
