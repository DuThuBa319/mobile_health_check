import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart';
import '../../../data/models/blood_sugar_model/blood_sugar_model.dart';

part 'blood_sugar_repository.impl.dart';

//repo này gọi đến rôp rest_api trên kia
abstract class BloodSugarRepository {
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  });
  Future<bool> createBloodSugarModel(
      {required String patientId, required BloodSugarModel bloodSugarModel});
}
