import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/user_model.dart';
import 'user_api_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final Dio dio;
  final RestApiRepository restApi;

  UserRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://retoolapi.dev/toSaX1/data');

  @override
  Future<List<UserModel>> getListUserModels() {
    return restApi.getListUserModels();
  }

  @override
  Future<UserModel> RegistUser(UserModel user) {
    return restApi.registuser(user);
  }
}
