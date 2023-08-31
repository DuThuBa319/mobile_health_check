
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


import '../../../../models/patient_infor_model/patient_infor_model.dart';
import '../../../../models/patient_list_model/patient_list_model.dart';
import '../../rest_api_repository.dart';
import 'patient_api_repository.dart';

@Injectable(as: PatientApiRepository)
class PatientApiRepositoryImpl implements PatientApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  PatientApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl:
                'https://healthcareapplicationcloud.azurewebsites.net/api');

  @override
  Future<List<PatientModel>> getPatientListModels() {
    return restApi.getPatientListModels();
  }

  // @override
  // Future<PatientModel> registPatient(PatientModel patient) {
  //   return restApi.registPatient(patient);
  // }

  @override
  Future<PatientInforModel> getPatientInforModel(String? id) {
    return restApi.getPatientInforModel(id);
  }
}
