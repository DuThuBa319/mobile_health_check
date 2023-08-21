import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/blood_sugar_entity.dart';

part 'blood_sugar_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BloodSugarModel {
  @JsonKey(name: 'value')
  double? bloodSugar;
  @JsonKey(name: 'timestamp')
  DateTime? updatedDate;
  @JsonKey(name: 'imageLink')
  String? imageLinkBloodSugar;
  BloodSugarModel(
      {this.bloodSugar, this.updatedDate, this.imageLinkBloodSugar});

  factory BloodSugarModel.fromJson(Map<String, dynamic> json) =>
      _$BloodSugarModelFromJson(json);

  Map<String, dynamic> toJson() => _$BloodSugarModelToJson(this);
  BloodSugarEntity getBloodSugarEntity() {
    return BloodSugarEntity(
        bloodSugar: bloodSugar,
        imageLink: imageLinkBloodSugar == "" ? null : imageLinkBloodSugar,
        updatedDate: updatedDate);
  }
}
