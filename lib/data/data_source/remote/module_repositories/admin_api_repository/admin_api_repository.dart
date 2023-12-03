import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import 'package:mobile_health_check/data/models/person_cell_model/person_cell_model.dart';


//? Abstract class chứa những method không có phần thân, chưa được triển khai => sẽ được thực hiện trong Implements
//? Abstract class được sử dụng các lớp trừu tượng làm interface.
abstract class AdminApiRepository {
  Future<void> createDoctorAccountModel(AccountModel? accountModel,String? adminId);
  Future<List<PersonCellModel>> getAllDoctorModel();
  Future<void> deleteDoctorModel(String? doctorId);
}
