import 'package:injectable/injectable.dart';

import '../../entities/temperature_entity.dart';
import '../../repositories/temperature_repository/temperature_repository.dart';

part 'temperature_usecase.impl.dart';

abstract class TemperatureUsecase {
  Future<List<TemperatureEntity>> getListTemperatureEntities();
  Future<TemperatureEntity> getTemperatureEntity({required int id});
}
