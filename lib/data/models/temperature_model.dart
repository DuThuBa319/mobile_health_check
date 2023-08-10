import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/temperature_entity.dart';

part 'temperature_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TemperatureModel {
  //int? id;
  @JsonKey(name: 'value')
  double? temperature;
  @JsonKey(name: 'timestamp')
  DateTime? updatedDate;
  String? imageLink;
  TemperatureModel({this.temperature, this.updatedDate, this.imageLink});

  factory TemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$TemperatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureModelToJson(this);
  TemperatureEntity getTemperatureEntity() {
    return TemperatureEntity(
        imageLink: imageLink,
        temperature: temperature,
        updatedDate: updatedDate);
  }
}
