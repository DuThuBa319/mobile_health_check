//repo này gọi đến rôp rest_api trên kia

import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import 'package:mobile_health_check/data/models/admin_infor_model/admin_infor_model.dart';

import '../../../data/data_source/remote/module_repositories/admin_api_repository/admin_api_repository.dart';
part 'admin_repository.impl.dart';

abstract class AdminRepository {
  Future<AdminInforModel>? getAdminInforModel({String? adminId});
  Future<void> createDoctorAccountModel(
      AccountModel? accountModel, String? adminId);

  Future<void> deleteDoctorModel(String? doctorId);
}
