import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import 'package:mobile_health_check/data/models/admin_infor_model/admin_infor_model.dart';

//? Abstract class chứa những method không có phần thân, chưa được triển khai => sẽ được thực hiện trong Implements
//? Abstract class được sử dụng các lớp trừu tượng làm interface.
abstract class AdminApiRepository {
  Future<AdminInforModel> getAdminInforModel({String? adminId});
  Future<void> createDoctorAccountModel(
      AccountModel? accountModel, String? adminId);
  Future<void> deleteDoctorModel(String? doctorId);
}
