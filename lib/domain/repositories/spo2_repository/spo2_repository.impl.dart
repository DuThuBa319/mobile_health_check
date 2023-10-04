// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'spo2_repository.dart';

@Injectable(
  as: Spo2Repository,
)
class Spo2RepositoryImpl extends Spo2Repository {
  final Spo2ApiRepository spo2Api;
  Spo2RepositoryImpl(
    this.spo2Api,
  );
  @override
  Future<List<Spo2Model>> getListSpo2Models({
    required String? patientId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return spo2Api.getListSpo2Models(
      patientId: patientId,
      endTime: endTime ?? endTime!,
      startTime: startTime ?? startTime!,
    );
  }

  @override
  Future<bool> createSpo2Model(
      {required Spo2Model spo2Model, required String patientId}) {
    return spo2Api.createSpo2Model(patientId: patientId, spo2Model: spo2Model);
  }
}

//repo này chứa một cái list<UserModel>