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
  Future<AdminInforEntity?> getAdminInforEntity({String? adminId}) async {
    final response = await _repository.getAdminInforModel(adminId: adminId);
    if (userDataData.getUser()?.role == UserRole.admin) {
      await userDataData.setUser(UserModel(
        id: userDataData.getUser()?.id,
        role: userDataData.getUser()?.role,
        name: userDataData.getUser()?.name,
        phoneNumber: response?.phoneNumber,
        email: userDataData.getUser()?.email,
      ));
    }
    final entity = response?.getAdminEntity();
    return entity;
  }

  @override
  Future<void> deleteDoctorEntity(String? doctorId) async {
    await _repository.deleteDoctorModel(doctorId);
  }
}
