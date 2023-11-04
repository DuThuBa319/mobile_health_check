import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../presentation/common_widget/enum_common.dart';

import '../../rest_api_repository.dart';
import 'reset_password_api_repository.dart';

@Injectable(as: ResetPasswordApiRepository)
class ResetPasswordApiRepositoryImpl implements ResetPasswordApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  ResetPasswordApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);

  @override
  Future<void> resetPasswordModel({String? userId}) {
    return restApi.resetPasswordModel(userId: userId);
  }
}
