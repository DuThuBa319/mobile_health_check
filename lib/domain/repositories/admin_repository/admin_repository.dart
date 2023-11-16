//repo này gọi đến rôp rest_api trên kia

import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/account_model/account_model.dart';

import '../../../data/data_source/remote/module_repositories/admin_api_repository/admin_api_repository.dart';
import '../../../data/models/person_cell_model/person_cell_model.dart';
part 'admin_repository.impl.dart';

abstract class AdminRepository {
  Future<void> createDoctorAccountModel(AccountModel? accountModel,String? adminId);
  Future<List<PersonCellModel>> getAllDoctorModel();
  Future<void> deleteDoctorModel(String? doctorId);
}
