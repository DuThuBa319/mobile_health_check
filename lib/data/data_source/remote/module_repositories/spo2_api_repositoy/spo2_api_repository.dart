import '../../../../models/spo2_model/spo2_model.dart';

abstract class Spo2ApiRepository {
  Future<List<Spo2Model>> getListSpo2Models({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  });

  
  Future<bool> createSpo2Model(
      {required String id, required Spo2Model spo2Model});
}
