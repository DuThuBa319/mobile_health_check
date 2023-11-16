part of 'admin_usecase.dart';

@Injectable(
  as: AdminUsecase,
)
class AdminUsecaseImpl extends AdminUsecase {
  final AdminRepository _repository;

  AdminUsecaseImpl(this._repository);

  @override
  Future<void> createDoctorAccountEntity(
      AccountEntity? accountEntity, String? adminId) async {
    await _repository.createDoctorAccountModel(
        accountEntity?.convertToAccountModel, adminId);
  }

  @override
  Future<List<PersonCellEntity>> getAllDoctorEntity() async {
    final allDoctorModel = await _repository.getAllDoctorModel();
    final responseEntities = <PersonCellEntity>[];
    for (final response in allDoctorModel) {
      responseEntities.add(response.convertToPersonCellEntity());
    }
    return responseEntities;
  }

  @override
  Future<void> deleteDoctorEntity(String? doctorId) async {
    await _repository.deleteDoctorModel(doctorId);
  }
}
