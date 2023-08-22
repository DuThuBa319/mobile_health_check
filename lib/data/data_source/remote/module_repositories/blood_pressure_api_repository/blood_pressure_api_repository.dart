import '../../../../models/blood_pressure_model.dart';

abstract class BloodPressureApiRepository {
  Future<List<BloodPressureModel>> getListBloodPressureModels({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<BloodPressureModel> getBloodPressureModel({
    required int id,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<BloodPressureModel> createBloodPressureModel(
      {required BloodPressureModel bloodPressureModel});
}
