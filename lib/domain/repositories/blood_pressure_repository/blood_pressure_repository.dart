import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/blood_pressure_api_repository/blood_pressure_api_repository.dart';
import '../../../data/models/blood_pressure_model/blood_pressure_model.dart';

part 'blood_pressure_repository.impl.dart';

//repo này gọi đến rôp rest_api trên kia
abstract class BloodPressureRepository {
  Future<List<BloodPressureModel>> getListBloodPressureModels({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  });

 
  Future<bool> createBloodPressureModel(
      {required String patientId, required BloodPressureModel bloodPressureModel});
}
