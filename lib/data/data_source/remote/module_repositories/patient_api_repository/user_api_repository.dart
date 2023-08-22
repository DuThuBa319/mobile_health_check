import '../../../../models/patient_infor_model.dart';
import '../../../../models/patient_list_model.dart';

abstract class UserApiRepository {
  Future<List<UserModel>> getListUserModels();
  Future<PatientInforModel> getPatientInforModel(String? id);
  Future<UserModel> RegistUser(UserModel user);
}
