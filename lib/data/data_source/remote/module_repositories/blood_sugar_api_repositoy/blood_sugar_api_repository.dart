import '../../../../models/blood_sugar_model/blood_sugar_model.dart';

abstract class BloodSugarApiRepository {
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<bool> createBloodSugarModel(
      {required String patientId, required BloodSugarModel bloodSugarModel});
}