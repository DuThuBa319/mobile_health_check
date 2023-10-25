import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_health_check/data/models/blood_pressure_model/blood_pressure_model.dart';
import 'package:mobile_health_check/data/models/blood_sugar_model/blood_sugar_model.dart';
import 'package:mobile_health_check/data/models/temperature_model/temperature_model.dart';
import 'package:mobile_health_check/domain/entities/notificaion_onesignal_entity.dart';

import '../spo2_model/spo2_model.dart';

part 'notification_onesignal_model.g.dart';

@JsonSerializable()
class NotificationModel {
  String? notificationId;
  String? heading;
  String? content;
  String? patientId;
  String? patientName;
  @JsonKey(name: "seen")
  bool? read;
  int? type;
  @JsonKey(name: "sendAt")
  DateTime? sendDate;
  @JsonKey(name: "bloodPressure")
  BloodPressureModel? bloodPressureModel;
  @JsonKey(name: "bloodSugar")
  BloodSugarModel? bloodSugarModel;
  @JsonKey(name: "bodyTemperature")
  TemperatureModel? bodyTemperatureModel;
  @JsonKey(name: "spO2")
  Spo2Model? spo2Model;



  NotificationModel({
    this.spo2Model,
    this.bloodPressureModel,
    this.bloodSugarModel,
    this.bodyTemperatureModel,
    this.type,
    this.notificationId,
    this.heading,
    this.content,
    this.patientId,
    this.patientName,
    this.read,
    this.sendDate,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  NotificationEntity convertNotificationEntity() {
    final notificationEntity = NotificationEntity(
        bloodPressureEntity: bloodPressureModel?.getBloodPressureEntity(),
        bloodSugarEntity: bloodSugarModel?.getBloodSugarEntity(),
        bodyTemperatureEntity: bodyTemperatureModel?.getTemperatureEntity(),
        content: content,
        heading: heading,
        notificaitonId: notificationId,
        patientId: patientId,
        patientName: patientName,
        read: read,
        sendDate: sendDate,
        spo2Entity: spo2Model?.getSpo2Entity(),
        type: type);
    return notificationEntity;
  }
}

@JsonSerializable()
class NotificationMetadata {
  NotificationMetadata();

  factory NotificationMetadata.fromJson(Map<String, dynamic> json) =>
      _$NotificationMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationMetadataToJson(this);
}
