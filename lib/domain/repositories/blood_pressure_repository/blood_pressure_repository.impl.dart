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
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return bloodPressureApi.getListBloodPressureModels(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<BloodPressureModel> getBloodPressureModel({
    required int id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return bloodPressureApi.getBloodPressureModel(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<BloodPressureModel> createBloodPressureModel(
      {required BloodPressureModel bloodPressureModel}) {
    return bloodPressureApi.createBloodPressureModel(
        bloodPressureModel: bloodPressureModel);
  }
}

//repo này chứa một cái list<UserModel>