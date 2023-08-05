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
  Future<List<BloodPressureModel>> getListBloodPressureModels() {
    return bloodPressureApi.getListBloodPressureModels();
  }

  @override
  Future<BloodPressureModel> getBloodPressureModel({required int id}) {
    return bloodPressureApi.getBloodPressureModel(id: id);
  }
}

//repo này chứa một cái list<UserModel>