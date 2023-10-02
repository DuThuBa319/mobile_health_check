import 'package:injectable/injectable.dart';

import '../../entities/blood_pressure_entity.dart';
import '../../repositories/blood_pressure_repository/blood_pressure_repository.dart';

part 'blood_pressure_usecase.impl.dart';

abstract class BloodPressureUsecase {
  Future<List<BloodPressureEntity>> getListBloodPressureEntities({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<bool> createBloodPressureEntity(
      {required String id, required BloodPressureEntity bloodPressureEntity});
}
