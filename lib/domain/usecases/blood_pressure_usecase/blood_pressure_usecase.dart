import 'package:injectable/injectable.dart';

import '../../entities/blood_pressure_entity.dart';
import '../../repositories/blood_pressure_repository/blood_pressure_repository.dart';

part 'blood_pressure_usecase.impl.dart';

abstract class BloodPressureUsecase {
  Future<List<BloodPressureEntity>> getListBloodPressureEntities();
  Future<BloodPressureEntity> getBloodPressureEntity({required int id});
  Future<BloodPressureEntity> createBloodPressureEntity(
      {required BloodPressureEntity bloodPressureEntity});
}