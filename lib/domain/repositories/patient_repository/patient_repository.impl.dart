// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'patient_repository.dart';

@Injectable(
  as: PatientListRepository,
)
class PatientListRepositoryImpl extends PatientListRepository {
  final PatientApiRepository _patientApi;

  PatientListRepositoryImpl(
    this._patientApi,
  );
  @override
  Future<PatientInforModel> getPatientInforModel(String? patientId) {
    return _patientApi.getPatientInforModel(patientId);
  }

  @override
  Future<void> updatePatientInforModel(
      String? userId, PatientInforModel? patientInforModel) {
    return _patientApi.updatePatientInforModel(userId, patientInforModel);
  }

  @override
  Future<void> addRelativeInforModel(
      String? patientId, AccountModel? accountModel) {
    return _patientApi.addRelativeInforModel(patientId, accountModel);
  }
}

//repo này chứa một cái list<PatientModel>