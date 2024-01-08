// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_repository.dart';

@Injectable(
  as: AdminRepository,
)
class AdminRepositoryImpl extends AdminRepository {
  final AdminApiRepository _adminInforApi;

  AdminRepositoryImpl(
    this._adminInforApi,
  );
  @override
  Future<AdminInforModel>? getAdminInforModel({String? adminId}) {
    return _adminInforApi.getAdminInforModel(adminId: adminId);
  }

  @override
  Future<void> createDoctorAccountModel(
      AccountModel? accountModel, String? adminId) {
    return _adminInforApi.createDoctorAccountModel(accountModel, adminId);
  }

  

  @override
  Future<void> deleteDoctorModel(String? doctorId) {
    return _adminInforApi.deleteDoctorModel(doctorId);
  }
}
