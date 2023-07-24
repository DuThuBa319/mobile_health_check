import 'package:json_annotation/json_annotation.dart';
import 'hourly_temperature_model.dart';
part 'temperature_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TemperatureModel {
  @JsonKey(name: 'hourly')
  HourlyTemperatureModel? hourlyTemperatureModel;

  TemperatureModel(this.hourlyTemperatureModel);

  factory TemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$TemperatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureModelToJson(this);
}