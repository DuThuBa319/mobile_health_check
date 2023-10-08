import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/cell_person_entity.dart';
part 'person_cell_model.g.dart';


//endpoint là các biến sẽ khai báo trong model
// còn trong thư viện retrofit thì các endpoint này còn có tên gọi là các @querry
@JsonSerializable(explicitToJson: true)
// igmnore: must_be_imutable
class PersonCellModel {
  String id;
  String name;
  String phoneNumber;
  PersonCellModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory PersonCellModel.fromJson(Map<String, dynamic> json) =>
      _$PersonCellModelFromJson(json);
  Map<String, dynamic> toJson() => _$PersonCellModelToJson(this);

  PersonCellEntity convertToPersonCellEntity() {
    return PersonCellEntity(
      id: id,
      name: name,
      phoneNumber: phoneNumber,    
    );
  }
}
