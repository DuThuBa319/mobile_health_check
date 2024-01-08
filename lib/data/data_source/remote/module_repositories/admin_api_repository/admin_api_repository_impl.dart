import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import 'package:mobile_health_check/data/models/admin_infor_model/admin_infor_model.dart';
import '../../../../../presentation/common_widget/enum_common.dart';
import '../../rest_api_repository.dart';
import 'admin_api_repository.dart';

@Injectable(as: AdminApiRepository)

//?  AdminApiRepository là interface của AdminApiRepositoryImpl,
//?  trong AdminApiRepositoryImpl phải định nghĩa lại mọi thứ có trong AdminApiRepository
//?  Có thể implements nhiều class khác nhau

class AdminApiRepositoryImpl implements AdminApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  AdminApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);

//! Lưu ý, khi sử implement => phải  @override hết tất cả các phương thức của class cha (kể cả class thường hoặc abstract class)

  @override
  Future<AdminInforModel> getAdminInforModel({String? adminId}) {
    return restApi.getAdminInforModel(adminId: adminId);
  }

  @override
  Future<void> createDoctorAccountModel(
      AccountModel? accountModel, String? adminId) {
    return restApi.createDoctorAccountModel(
        accountModel: accountModel, adminId: adminId);
  }

  @override
  Future<void> deleteDoctorModel(String? doctorId) {
    return restApi.deleteDoctor(doctorId: doctorId);
  }
}
