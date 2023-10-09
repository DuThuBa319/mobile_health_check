// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_repository.dart';

@Injectable(
  as: AdminRepository,
)
class AdminRepositoryImpl extends AdminRepository {
  final AdminApiRepository _doctorInforApi;

  AdminRepositoryImpl(
    this._doctorInforApi,
  );

  @override
  Future<void> createDoctorAccountModel(AccountModel? accountModel) {
    return _doctorInforApi.createDoctorAccountModel(accountModel);
  }

  @override
  Future<List<PersonCellModel>> getAllDoctorModel() {
    return _doctorInforApi.getAllDoctorModel();
  }

  @override
  Future<void> deleteDoctorModel(String? doctorId) {
    return _doctorInforApi.deleteDoctorModel(doctorId);
  }
}