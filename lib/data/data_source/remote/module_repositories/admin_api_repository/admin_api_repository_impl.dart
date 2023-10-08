import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/person_cell_model/person_cell_model.dart';
import '../../rest_api_repository.dart';
import 'admin_api_repository.dart';

@Injectable(as: AdminApiRepository)
class AdminApiRepositoryImpl implements AdminApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  AdminApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);

  @override
  Future<void> createDoctorAccountModel(AccountModel? accountModel) {
    return restApi.createDoctorAccountModel(accountModel);
  }

  @override
  Future<List<PersonCellModel>> getAllDoctorModel() {
    return restApi.getAllDoctorModel();
  }

  @override
  Future<void> deleteDoctorModel(String? doctorId) {
    return restApi.deleteDoctor(doctorId);
  }
}
