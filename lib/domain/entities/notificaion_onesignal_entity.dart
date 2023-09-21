import 'package:mobile_health_check/domain/entities/spo2_entity.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';

import 'blood_pressure_entity.dart';
import 'blood_sugar_entity.dart';

class NotificationEntity {
  String? notificaitonId;
  String? heading;
  String? content;
  String? patientId;
  String? patientName;
  bool? read;
  DateTime? sendDate;
  BloodPressureEntity? bloodPressureEntity;
  BloodSugarEntity? bloodSugarEntity;
  TemperatureEntity? bodyTemperatureEntity;
  Spo2Entity? spo2Entity;
  int? type;

  NotificationEntity({
    this.spo2Entity,
    this.bloodPressureEntity,
    this.bloodSugarEntity,
    this.bodyTemperatureEntity,
    this.type,
    this.patientName,
    this.notificaitonId,
    this.heading,
    this.content,
    this.patientId,
    this.read,
    this.sendDate,
  });
}
