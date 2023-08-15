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
  @JsonKey(name: 'imageLink')
  String? imageLink;
  @JsonKey(name: 'timestamp')
  DateTime? updatedDate;

  BloodPressureModel({
    this.dia,
    this.sys,
    this.pulse,
    this.imageLink,
    this.updatedDate,
  });

  factory BloodPressureModel.fromJson(Map<String, dynamic> json) =>
      _$BloodPressureModelFromJson(json);

  Map<String, dynamic> toJson() => _$BloodPressureModelToJson(this);
  BloodPressureEntity getBloodPressureEntity() {
    return BloodPressureEntity(
        dia: dia,
        sys: sys,
        pulse: pulse,
        imageLink: imageLink == "" ? null : imageLink,
        updatedDate: updatedDate);
  }
}
