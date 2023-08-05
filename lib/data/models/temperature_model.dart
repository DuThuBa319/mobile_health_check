import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/temperature_entity.dart';

part 'temperature_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TemperatureModel {
  int? id;
  double? temperature;
  DateTime? updatedDate;
  TemperatureModel({this.temperature, this.updatedDate, this.id});

  factory TemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$TemperatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureModelToJson(this);
  TemperatureEntity getTemperatureEntity() {
    return TemperatureEntity(
        id: id, temperature: temperature, updatedDate: updatedDate);
  }
}
