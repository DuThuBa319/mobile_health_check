// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'blood_sugar_repository.dart';

@Injectable(
  as: BloodSugarRepository,
)
class BloodSugarRepositoryImpl extends BloodSugarRepository {
  final BloodSugarApiRepository bloodSugarApi;
  BloodSugarRepositoryImpl(
    this.bloodSugarApi,
  );
  @override
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return bloodSugarApi.getListBloodSugarModels(
      patientId: patientId,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<bool> createBloodSugarModel(
      {required BloodSugarModel bloodSugarModel, required String patientId}) {
    return bloodSugarApi.createBloodSugarModel(
        patientId: patientId, bloodSugarModel: bloodSugarModel);
  }
}

//repo này chứa một cái list<UserModel>