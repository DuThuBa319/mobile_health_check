import 'package:injectable/injectable.dart';

import '../../entities/blood_sugar_entity.dart';
import '../../repositories/blood_sugar_repository/blood_sugar_repository.dart';

part 'blood_sugar_usecase.impl.dart';

abstract class BloodSugarUsecase {
  Future<List<BloodSugarEntity>> getListBloodSugarEntities({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  });
  Future<BloodSugarEntity> getBloodSugarEntity({required int id});
}
