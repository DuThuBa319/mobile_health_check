import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/patient_infor_model/patient_infor_model.dart';
import '../../../../models/relative_model/relative_infor_model.dart';
import '../../rest_api_repository.dart';
import 'patient_api_repository.dart';

@Injectable(as: PatientApiRepository)
class PatientApiRepositoryImpl implements PatientApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  PatientApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://healthcareapplicationcloud.azurewebsites.net');

  // @override
  // Future<List<PatientModel>> getPatientListModels() {
  //   return restApi.getPatientListModels();
  // }

  @override
  Future<PatientInforModel> getPatientInforModel(String? id) {
    return restApi.getPatientInforModel(id);
  }

  @override
  Future<void> updatePatientInforModel(
      String? id, PatientInforModel? patientInforModel) {
    return restApi.updatePatientInforModel(id, patientInforModel);
  }

  @override
  Future<RelativeInforModel>? addRelativeInforModel(
      String? patientId, RelativeInforModel? relativeInforModel) {
    return restApi.addRelativeInforModel(patientId, relativeInforModel);
  }

  
   
  // @override
  // Future<PatientModel> registPatient(PatientModel patient) {
  //   return restApi.registPatient(patient);
  // }
}
