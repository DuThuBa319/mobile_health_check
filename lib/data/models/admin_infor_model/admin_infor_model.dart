import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_health_check/data/models/person_cell_model/person_cell_model.dart';
import 'package:mobile_health_check/domain/entities/admin_infor_entity.dart';
import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';
// import '../../domain/entities/blood_sugar_entity.dart';
// import '../../domain/entities/Admin_infor_entity.dart';

part 'admin_infor_model.g.dart';

//endpoint là các biến sẽ khai báo trong model
// còn trong thư viện retrofit thì các endpoint này còn có tên gọi là các @querry
@JsonSerializable(explicitToJson: true)
// igmnore: must_be_imutable
class AdminInforModel {
  String id;
  String name;
  int? personType;
  String phoneNumber;
  List<PersonCellModel>? doctors;
  AdminInforModel({
    required this.id,
    required this.name,
    this.personType,
    required this.phoneNumber,
    this.doctors,
  });

  factory AdminInforModel.fromJson(Map<String, dynamic> json) =>
      _$AdminInforModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdminInforModelToJson(this);

//! Chuyển từ Model về Entity
  AdminInforEntity getAdminEntity() {
    List<PersonCellEntity> doctorEntities = [];
    if (doctors != null) {
      for (var model in doctors!) {
        doctorEntities.add(model.convertToPersonCellEntity());
      }
    }
    return AdminInforEntity(
      id: id,
      name: name,
      personType: personType,
      phoneNumber: phoneNumber,
      doctors: doctorEntities,
    );
  }
}
