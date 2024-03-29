part of 'patient_usecase.dart';

@Injectable(
  as: PatientUsecase,
)
class PatientUsecaseImpl extends PatientUsecase {
  final PatientListRepository _repository;

  PatientUsecaseImpl(this._repository);

  @override
  Future<PatientInforEntity?> getPatientInforEntity(String? patientId) async {
    final response = await _repository.getPatientInforModel(patientId);
    final entity = response.getPatientInforEntity();
    return entity;
  }

  @override
  Future<void> updatePatientInforEntity(
      String? userId, PatientInforEntity? patientInforEntity) async {
    final patientInforModel = patientInforEntity?.convertToPatientInforModel;
    await _repository.updatePatientInforModel(userId, patientInforModel);
  }

  @override
  Future<PatientInforEntity?> getPatientInforEntityInPatientApp(
      String? patientId) async {
    final response = await _repository.getPatientInforModel(patientId);
    await userDataData.setUser(UserModel(
      height: response.height,
      weight: response.weight,
      address: response.address ??
          translation(navigationService.navigatorKey.currentContext!).notUpdate,
      age: response.age ?? 0,
      gender: response.gender,
      id: userDataData.getUser()!.id,
      role: userDataData.getUser()!.role,
      name: userDataData.getUser()!.name,
      phoneNumber: response.phoneNumber,
      email: userDataData.getUser()!.email,
      doctor: response.doctor,
      relatives: response.relatives,
      bloodPressureImagesTakenToday:
          response.bloodPressureImagesTakenToday ?? 0,
      bloodSugarImagesTakenToday: response.bloodSugarImagesTakenToday ?? 0,
      bodyTemperatureImagesTakenToday:
          response.bodyTemperatureImagesTakenToday ?? 0,
      spO2ImagesTakenToday: response.spO2ImagesTakenToday ?? 0,
      // imagesTakenToday: response.imagesTakenToday ?? 0
    ));
    final entity = response.getPatientInforEntityPatientApp();
    return entity;
  }

  @override
  Future<void> addRelativeInforEntity(
      String? patientId, AccountEntity? accountEntity) async {
    await _repository.addRelativeInforModel(
        patientId, accountEntity?.convertToAccountModel);
    // return accountModel?.convertAccountEntity();
  }
}
