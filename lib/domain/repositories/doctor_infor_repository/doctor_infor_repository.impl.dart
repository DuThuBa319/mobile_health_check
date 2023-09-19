// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'doctor_infor_repository.dart';

@Injectable(
  as: DoctorInforRepository,
)
class DoctorInforRepositoryImpl extends DoctorInforRepository {
  final DoctorInforApiRepository _doctorInforApi;

  DoctorInforRepositoryImpl(
    this._doctorInforApi,
  );
  @override
  Future<DoctorInforModel>? getDoctorInforModel(String? id) {
    return _doctorInforApi.getDoctorInforModel(id);
  }

  @override
  Future<PatientInforModel>? addPatientInforModel(
      String? doctorId, PatientInforModel? patientInforModel) {
    return _doctorInforApi.addPatientInforModel(doctorId, patientInforModel);
  }

  @override
  Future<void> deleteRelationshipDoctorAndPatientModel(String? doctorId, String? patientId) {
    return _doctorInforApi.deleteRelationshipDoctorAndPatientModel(doctorId, patientId);
  }
  @override
  Future<void> deleteRelationshipRelativeAndPatientModel(String? relativeId, String? patientId) {
    return _doctorInforApi.deleteRelationshipDoctorAndPatientModel( relativeId, patientId);
  }
   @override
  Future<void> deletePatientModel( String? patientId) {
    return _doctorInforApi.deletePatientModel( patientId);
  }
 @override
  Future<void> deleteRelativeModel( String? relativeId) {
    return _doctorInforApi.deleteRelativeModel( relativeId);
  }
}
