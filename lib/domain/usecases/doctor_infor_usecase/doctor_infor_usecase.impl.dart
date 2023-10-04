part of 'doctor_infor_usecase.dart';

@Injectable(
  as: DoctorInforUsecase,
)
class DoctorInforUsecaseImpl extends DoctorInforUsecase {
  final DoctorInforRepository _repository;

  DoctorInforUsecaseImpl(this._repository);

  @override
  Future<DoctorInforEntity?> getDoctorInforEntity(String? doctorId) async {
    final response = await _repository.getDoctorInforModel(doctorId);
    final entity = response?.getDoctorInforEntity();
    await userDataData.setUser(UserModel(
      address: response?.address ?? "chưa có thông tin",
      age: response?.age ?? 0,
      gender: response?.gender,
      id: userDataData.getUser()!.id,
      role: userDataData.getUser()!.role,
      name: userDataData.getUser()!.name,
      phoneNumber: response?.phoneNumber,
      email: userDataData.getUser()!.email,
    ));
    return entity;
  }

  @override
  Future<void> addPatientEntity(
      String? doctorId, PatientInforModel? patientInforModel) async {
    // final accountModel =
        await _repository.addPatientInforModel(doctorId, patientInforModel);

    // final accountEntity = accountModel?.convertAccountEntity();
    // return accountEntity;
  }

  @override
  Future<void> updateDoctorInforEntity(
      String? doctorId, DoctorInforEntity? doctorInforEntity) async {
    final doctorInforModel = doctorInforEntity?.convertToDoctorInforModel;
    await _repository.updateDoctorInforModel(doctorId, doctorInforModel);
  }

  @override
  Future<void> deletePatientEntity(String? patientId) async {
    await _repository.deletePatientModel(patientId);
  }

  @override
  Future<void> deleteRelativeEntity(
      String? relativeId, String? patientId) async {
    await _repository.deleteRelativeModel(
        relativeId: relativeId, patientId: patientId);
  }
}
