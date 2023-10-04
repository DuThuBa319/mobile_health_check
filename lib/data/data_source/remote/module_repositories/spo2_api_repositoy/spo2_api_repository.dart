import '../../../../models/spo2_model/spo2_model.dart';

abstract class Spo2ApiRepository {
  Future<List<Spo2Model>> getListSpo2Models({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  });

  
  Future<bool> createSpo2Model(
      {required String patientId, required Spo2Model spo2Model});
}
