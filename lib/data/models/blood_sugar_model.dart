import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/blood_sugar_entity.dart';

part 'blood_sugar_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BloodSugarModel {
  int? id;
  double? bloodSugar;
  DateTime? updatedDate;
  BloodSugarModel({this.bloodSugar, this.updatedDate, this.id});

  factory BloodSugarModel.fromJson(Map<String, dynamic> json) =>
      _$BloodSugarModelFromJson(json);

  Map<String, dynamic> toJson() => _$BloodSugarModelToJson(this);
  BloodSugarEntity getBloodSugarEntity() {
    return BloodSugarEntity(
        id: id, bloodSugar: bloodSugar, updatedDate: updatedDate);
  }
}
