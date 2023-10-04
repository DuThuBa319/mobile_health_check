import 'package:injectable/injectable.dart';

import '../../entities/spo2_entity.dart';
import '../../repositories/spo2_repository/spo2_repository.dart';

part 'spo2_usecase.impl.dart';

abstract class Spo2Usecase {
  Future<List<Spo2Entity>> getListSpo2Entities({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  });
  Future<bool> createSpo2Entity(
      {required String patientId, required Spo2Entity spo2Entity});
}
