import '../../../../models/blood_sugar_model.dart';

abstract class BloodSugarApiRepository {
  Future<List<BloodSugarModel>> getListBloodSugarModels();
  Future<BloodSugarModel> getBloodSugarModel({required int id});
}
