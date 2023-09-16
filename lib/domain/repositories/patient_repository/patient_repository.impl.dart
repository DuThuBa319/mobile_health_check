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
  // @override
  // Future<List<PatientModel>?> getPatientListModels() {
  //   return _patientApi.getPatientListModels();
  // }

  // @override
  // Future<PatientModel> addPatientModel(PatientModel patient) {
  //   return _patientApi.registPatient(patient);
  // }

  @override
  Future<PatientInforModel> getPatientInforModel(String? id) {
    return _patientApi.getPatientInforModel(id);
  }
   @override
  Future<void> updatePatientInforModel(String? id,PatientInforModel? patientInforModel) {
    return _patientApi.updatePatientInforModel(id,patientInforModel);
  }
    @override
  Future<RelativeInforModel>? addRelativeInforModel(String? patientId,RelativeInforModel? relativeInforModel) {
    return _patientApi.addRelativeInforModel(patientId,relativeInforModel);
  }
 
}

//repo này chứa một cái list<PatientModel>