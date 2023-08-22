import 'package:mobile_health_check/data/data_source/remote/rest_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/patient_infor_model.dart';

import '../../../../models/patient_list_model.dart';
import 'user_api_repository.dart';

@Injectable(as: UserApiRepository)
class UserApiRepositoryImpl implements UserApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  UserApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl:
                'https://healthcareapplicationcloud.azurewebsites.net/api');

  @override
  Future<List<UserModel>> getListUserModels() {
    return restApi.getListUserModels();
  }

  @override
  Future<UserModel> RegistUser(UserModel user) {
    return restApi.registuser(user);
  }

  @override
  Future<PatientInforModel> getPatientInforModel(String? id) {
    return restApi.getPatientInforModel(id);
  }
}
