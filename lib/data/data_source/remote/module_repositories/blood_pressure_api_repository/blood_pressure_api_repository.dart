import '../../../../models/blood_pressure_model.dart';

abstract class BloodPressureApiRepository {
  Future<List<BloodPressureModel>> getListBloodPressureModels();

  Future<BloodPressureModel> getBloodPressureModel({required int id});
  
  Future<BloodPressureModel> createBloodPressureModel(
      {required BloodPressureModel bloodPressureModel});
}