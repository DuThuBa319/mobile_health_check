import 'package:mobile_health_check/data/models/admin_infor_model/admin_infor_model.dart';
import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';

import '../../common/service/local_manager/user_data_datasource/user.dart';

class AdminInforEntity {
  String id;
  String name;
  int? personType;
  String phoneNumber;
  List<PersonCellEntity>? doctors;

  AdminInforEntity({
    required this.id,
    required this.name,
    this.personType,
    required this.phoneNumber,
    this.doctors,
  });

  AdminInforModel get convertToAdminInforModel {
   return AdminInforModel(
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        personType: personType);
  }
    User convertUser({required User user}) {
    return user.copyWith(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity