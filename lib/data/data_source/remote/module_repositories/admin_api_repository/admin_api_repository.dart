import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import 'package:mobile_health_check/data/models/person_cell_model/person_cell_model.dart';

abstract class AdminApiRepository {
  Future<void> createDoctorAccountModel(AccountModel? accountModel);
  Future<List<PersonCellModel>> getAllDoctorModel();
  Future<void> deleteDoctorModel(String? doctorId);
}
