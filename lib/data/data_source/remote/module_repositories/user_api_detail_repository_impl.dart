import 'package:common_project/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'user_api_detail_repository.dart';
import '../../../models/user_model.dart';

@Injectable(
  as: UserDetailRepository,
)
class UserDetailRepositoryImpl implements UserDetailRepository {
  final Dio dio;

  final RestApiRepository restApi;

  UserDetailRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://retoolapi.dev/toSaX1/data');

  @override
  Future<UserModel> getUserModel(int id) {
    return restApi.getUserModel(id);
  }

  @override
  Future<void> DeleteUser(int id) {
    return restApi.deleteUser(id);
  }

  @override
  Future<void> UpdateUser(int id, UserModel user) {
    return restApi.updateUser(id, user);
  }
}
