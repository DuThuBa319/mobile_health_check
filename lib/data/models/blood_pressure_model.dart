import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/blood_pressure_entity.dart';

part 'blood_pressure_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BloodPressureModel {
  int? id;
  String? sys;
  String? dia;
  String? pulse;
  DateTime? updatedDate;
  BloodPressureModel(
      {this.dia, this.pulse, this.sys, this.updatedDate, this.id});

  factory BloodPressureModel.fromJson(Map<String, dynamic> json) =>
      _$BloodPressureModelFromJson(json);

  Map<String, dynamic> toJson() => _$BloodPressureModelToJson(this);
  BloodPressureEntity getBloodPressureEntity() {
    return BloodPressureEntity(
        id: id,
        sys: int.parse(sys!),
        dia: int.parse(dia!),
        pulse: int.parse(pulse!),
        updatedDate: updatedDate);
  }
}
