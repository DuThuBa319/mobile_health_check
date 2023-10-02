import '../../../../models/blood_pressure_model/blood_pressure_model.dart';

abstract class BloodPressureApiRepository {
  Future<List<BloodPressureModel>> getListBloodPressureModels({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<bool> createBloodPressureModel(
      {required String id, required BloodPressureModel bloodPressureModel});
}
