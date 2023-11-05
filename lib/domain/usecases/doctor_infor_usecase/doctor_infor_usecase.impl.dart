part of 'doctor_infor_usecase.dart';

@Injectable(
  as: DoctorInforUsecase,
)
class DoctorInforUsecaseImpl extends DoctorInforUsecase {
  final DoctorInforRepository _repository;

  DoctorInforUsecaseImpl(this._repository);

  @override
  Future<DoctorInforEntity?> getDoctorInforEntity(String? doctorId) async {
    NavigationService navigationService = injector<NavigationService>();

    final response = await _repository.getDoctorInforModel(doctorId);
    final entity = response?.getDoctorInforEntity();
    if (userDataData.getUser()?.role == UserRole.doctor) {
      await userDataData.setUser(UserModel(
        address: response?.address ??
            translation(navigationService.navigatorKey.currentContext!)
                .notUpdate,
        age: response?.age ?? 0,
        gender: response?.gender,
        id: userDataData.getUser()!.id,
        role: userDataData.getUser()!.role,
        name: userDataData.getUser()!.name,
        phoneNumber: response?.phoneNumber,
        email: userDataData.getUser()!.email,
      ));
    }
    ;
    return entity;
  }

  @override
  Future<void> addPatientEntity(
      String? doctorId, AccountEntity? accountEntity) async {
    await _repository.addPatientInforModel(
        doctorId, accountEntity?.convertToAccountModel);
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
  Future<void> removeRelationshipRaPEntity(
      String? relativeId, String? patientId) async {
    await _repository.removeRelationshipRaPModel(
        relativeId: relativeId, patientId: patientId);
  }
}
