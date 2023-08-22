import 'package:injectable/injectable.dart';

import 'package:mobile_health_check/data/models/patient_list_model.dart';

import '../../../data/data_source/remote/module_repositories/patient_api_repository/user_api_repository.dart';
import '../../../data/models/patient_infor_model.dart';

part 'patient_repository.impl.dart';

//repo này gọi đến rôp rest_api trên kia
abstract class UserListRepository {
  Future<List<UserModel>?> getListUserModels();
  Future<UserModel> AddUserModel(UserModel user);
  Future<PatientInforModel>getPatientInforModel(String? id);
}
