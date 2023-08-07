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
  Future<List<BloodSugarModel>> getListBloodSugarModels() {
    return bloodSugarApi.getListBloodSugarModels();
  }

  @override
  Future<BloodSugarModel> getBloodSugarModel({required int id}) {
    return bloodSugarApi.getBloodSugarModel(id: id);
  }
}

//repo này chứa một cái list<UserModel>