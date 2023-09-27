part of 'patient_usecase.dart';

@Injectable(
  as: PatientUsecase,
)
class PatientUsecaseImpl extends PatientUsecase {
  final PatientListRepository _repository;

  PatientUsecaseImpl(this._repository);

  @override
  Future<PatientInforEntity>? getPatientInforEntity(String? id) async {
    final response = await _repository.getPatientInforModel(id);

    final entity = response.getPatientInforEntity();
    return entity;
  }

  @override
  Future<void> updatePatientInforEntity(
      String? id, PatientInforModel? patientInforModel) async {
    await _repository.updatePatientInforModel(id, patientInforModel);
  }

  @override
  Future<PatientInforEntity>? getPatientInforEntityInPatientApp(
      String? id) async {
    final response = await _repository.getPatientInforModel(id);
    await userDataData.setUser(UserModel(
        height: response.height,
        weight: response.weight,
        address: response?.address ?? "chưa có thông tin",
        age: response?.age ?? 0,
        gender: response?.gender == 0 ? false : true,
        id: userDataData.getUser()!.id,
        role: userDataData.getUser()!.role,
        name: userDataData.getUser()!.name,
        phoneNumber: response?.phoneNumber,
        email: userDataData.getUser()!.email,
        doctor: response.doctor,
        relatives: response.relatives));
    final entity = response.getPatientInforEntityPatientApp();
    return entity;
  }

  @override
  Future<void>? addRelativeInforEntity(
      String? patientId, RelativeInforModel? relativeInforModel) async {
    await _repository.addRelativeInforModel(patientId, relativeInforModel);
  }

  // @override
  // Future<List<PatientEntity>?> getPatientListEntity() async {
  //   final responses = await _repository.getPatientListModels();
  //   final responseEntities = <PatientEntity>[];
  //   if (responses != null) {
  //     for (final response in responses) {
  //       final entity = response.getPatientEntity();
  //       responseEntities.add(entity);
  //     }
  //   }

  //   return responseEntities;
  // }
  // @override
  // Future<PatientEntity> addPatientEntity(PatientModel Patient) async {
  //   try {
  //     final response = await _repository.RegistPatient(Patient);
  //     final newPatient = PatientEntity(
  //         id: response.id,
  //         age: response.age,
  //         name: response.name,
  //         phoneNumber: response.phoneNumber,
  //         avatarPath: response.avatarPath,
  //         height: response.height,
  //         personType: response.personType,
  //         weight: response.weight);

  //     return newPatient;
  //   } catch (e) {
  //     throw Exception('Failed to add Patient');
  //   }
  // }
}
