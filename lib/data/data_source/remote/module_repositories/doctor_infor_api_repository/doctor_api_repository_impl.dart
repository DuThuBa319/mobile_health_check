import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../models/doctor_infor_model/doctor_infor_model.dart';
import '../../rest_api_repository.dart';
import 'doctor_api_repository.dart';

@Injectable(as: DoctorInforApiRepository)
class DoctorInforApiRepositoryImpl implements DoctorInforApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  DoctorInforApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl:
                'https://healthcareapplicationcloud.azurewebsites.net/api');

  @override
  Future<DoctorInforModel> getDoctorInforModel(String? id) {
    return restApi.getDoctorInforModel(id);
  }
}
