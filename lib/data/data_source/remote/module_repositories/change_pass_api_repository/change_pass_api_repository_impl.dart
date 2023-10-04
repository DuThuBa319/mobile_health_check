import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../presentation/common_widget/enum_common.dart';

import '../../../../models/change_password_model/change_password_model.dart';
import '../../rest_api_repository.dart';
import 'change_pass_api_repository.dart';

@Injectable(as: ChangePassApiRepository)
class ChangePassApiRepositoryImpl implements ChangePassApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  ChangePassApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);

  @override
  Future<void> changePassModel(
      String? userId, ChangePassModel? changePassModel) {
    return  restApi.changePassModel(
        userId: userId, changePassModel: changePassModel);
  }
}
