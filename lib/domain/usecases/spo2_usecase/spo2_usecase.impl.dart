part of 'spo2_usecase.dart';

@Injectable(
  as: Spo2Usecase,
)
class Spo2UsecaseImpl extends Spo2Usecase {
  final Spo2Repository _repository;

  Spo2UsecaseImpl(this._repository);

  @override
  Future<List<Spo2Entity>> getListSpo2Entities({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    final responses = await _repository.getListSpo2Models(
      patientId: patientId,
      endTime: endTime ,
      startTime: startTime,
    );

    var responseEntities = <Spo2Entity>[];
    for (final response in responses) {
      responseEntities.add(response.getSpo2Entity());
    }

    return responseEntities;
  }


  @override
  Future<bool> createSpo2Entity(
      {required String patientId, required Spo2Entity spo2Entity}) 
      async {
    final spo2model = spo2Entity.getSpo2Model();
    final response = await _repository.createSpo2Model(
        patientId: patientId, spo2Model: spo2model);
    return response;
  }
}
