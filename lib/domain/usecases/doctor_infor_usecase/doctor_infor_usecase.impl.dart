part of 'doctor_infor_usecase.dart';

@Injectable(
  as: DoctorInforUsecase,
)
class DoctorInforUsecaseImpl extends DoctorInforUsecase {
  final DoctorInforRepository _repository;

  DoctorInforUsecaseImpl(this._repository);

  @override
  Future<DoctorInforEntity?> getDoctorInforEntity(String? id) async {
    final response = await _repository.getDoctorInforModel(id);
    final entity = response?.getDoctorInforEntity();
    return entity;
  }

  @override
  Future<AccountEntity?> addPatientEntity(
      String? doctorId, PatientInforModel? patientInforModel) async {
    final accountModel =await _repository.addPatientInforModel(doctorId, patientInforModel);
    
    final accountEntity = accountModel?.convertAccountEntity();
    return accountEntity;

    // return accountEntity;
// return response;
  }

  @override
  Future<void> deleteRelationshipDoctorAndPatientEntity(
      String? doctorId, String? patientId) async {
    await _repository.deleteRelationshipDoctorAndPatientModel(
        doctorId, patientId);
  }

  @override
  Future<void> deleteRelationshipRelativeAndPatientEntity(
      String? relativeId, String? patientId) async {
    await _repository.deleteRelationshipDoctorAndPatientModel(
        relativeId, patientId);
  }

  @override
  Future<void> deletePatientEntity(String? patientId) async {
    await _repository.deletePatientModel(patientId);
  }

  @override
  Future<void> deleteRelativeEntity(String? relativeId) async {
    await _repository.deleteRelativeModel(relativeId);
  }
}
