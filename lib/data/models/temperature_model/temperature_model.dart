import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/temperature_entity.dart';

part 'temperature_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TemperatureModel {
  //int? id;
  @JsonKey(name: 'value')
  double? temperature;
  @JsonKey(name: 'timestamp')
  DateTime? updatedDate;
  @JsonKey(name: 'imageLink')
  String? imageLinkTemperature;
  TemperatureModel({this.temperature, this.updatedDate, this.imageLinkTemperature});

  factory TemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$TemperatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureModelToJson(this);

  TemperatureEntity getTemperatureEntity() {
    return TemperatureEntity(
        temperature: temperature,
        imageLink: imageLinkTemperature == "" ? null : imageLinkTemperature,
        updatedDate: updatedDate);
  }
}
