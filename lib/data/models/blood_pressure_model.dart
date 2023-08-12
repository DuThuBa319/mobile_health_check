import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/blood_pressure_entity.dart';

part 'blood_pressure_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BloodPressureModel {
  @JsonKey(name: 'systolic')
  int? sys;
  @JsonKey(name: 'diastolic')
  int? dia;
  @JsonKey(name: 'pulseRate')
  int? pulse;
  @JsonKey(name: 'timestamp')
  DateTime? updatedDate;
  @JsonKey(name: 'imageLink"')
  String? imageLink;
  BloodPressureModel(
      {this.dia, this.pulse, this.sys, this.updatedDate, this.imageLink});

  factory BloodPressureModel.fromJson(Map<String, dynamic> json) =>
      _$BloodPressureModelFromJson(json);

  Map<String, dynamic> toJson() => _$BloodPressureModelToJson(this);
  BloodPressureEntity getBloodPressureEntity() {
    return BloodPressureEntity(
        imageLink: imageLink,
        sys: sys,
        dia: dia,
        pulse: pulse,
        updatedDate: updatedDate);
  }
}
