// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'blood_pressure_repository.dart';

@Injectable(
  as: BloodPressureRepository,
)
class BloodPressureRepositoryImpl extends BloodPressureRepository {
  final BloodPressureApiRepository bloodPressureApi;
  BloodPressureRepositoryImpl(
    this.bloodPressureApi,
  );
  @override
  Future<List<BloodPressureModel>> getListBloodPressureModels({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return bloodPressureApi.getListBloodPressureModels(
      patientId: patientId,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }


  @override
  Future<bool> createBloodPressureModel(
      {required BloodPressureModel bloodPressureModel, required String patientId}) {
    return bloodPressureApi.createBloodPressureModel(
        patientId: patientId, bloodPressureModel: bloodPressureModel);
  }
}

//repo này chứa một cái list<UserModel>