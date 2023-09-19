import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/spo2_entity.dart';

part 'spo2_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Spo2Model {
  @JsonKey(name: 'value')
  int? spo2;
  @JsonKey(name: 'timestamp')
  DateTime? updatedDate;
  @JsonKey(name: 'imageLink')
  String? imageLinkSpo2;
  Spo2Model({this.spo2, this.updatedDate, this.imageLinkSpo2});

  factory Spo2Model.fromJson(Map<String, dynamic> json) =>
      _$Spo2ModelFromJson(json);

  Map<String, dynamic> toJson() => _$Spo2ModelToJson(this);
  Spo2Entity getSpo2Entity() {
    return Spo2Entity(
        spo2: spo2,
        imageLink: imageLinkSpo2 == "" ? null : imageLinkSpo2,
        updatedDate: updatedDate);
  }
}
