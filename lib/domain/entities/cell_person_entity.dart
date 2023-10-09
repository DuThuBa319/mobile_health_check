import 'package:mobile_health_check/data/models/person_cell_model/person_cell_model.dart';

class PersonCellEntity {
  String id;
  String name;
  String phoneNumber;

  PersonCellEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  PersonCellModel get convertToPersonCellModel {
    return PersonCellModel(id: id, name: name, phoneNumber: phoneNumber);
  }
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity