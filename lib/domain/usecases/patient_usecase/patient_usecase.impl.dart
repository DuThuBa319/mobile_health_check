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
  Future<void> updatePatientInforEntity(String? id,PatientInforModel? patientInforModel) async {
   await _repository.updatePatientInforModel(id,patientInforModel);
   
  }



@override
  Future<PatientInforEntity>? getPatientInforEntityInPatientApp(String? id) async {
    final response = await _repository.getPatientInforModel(id);
    final entity = response.getPatientInforEntityPatientApp();
    return entity;
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
