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
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return bloodSugarApi.getListBloodSugarModels(
      id: id,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<BloodSugarModel> getBloodSugarModel({required int id}) {
    return bloodSugarApi.getBloodSugarModel(id: id);
  }

  @override
  Future<bool> createBloodSugarModel(
      {required BloodSugarModel bloodSugarModel, required String id}) {
    return bloodSugarApi.createBloodSugarModel(
        id: id, bloodSugarModel: bloodSugarModel);
  }
}

//repo này chứa một cái list<UserModel>