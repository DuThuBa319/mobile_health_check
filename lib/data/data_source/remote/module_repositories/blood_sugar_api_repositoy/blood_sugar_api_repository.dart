import '../../../../models/blood_sugar_model/blood_sugar_model.dart';

abstract class BloodSugarApiRepository {
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<bool> createBloodSugarModel(
      {required String id, required BloodSugarModel bloodSugarModel});
}
