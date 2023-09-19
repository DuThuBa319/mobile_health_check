// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_onesignal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      spo2Model: json['spO2'] == null
          ? null
          : Spo2Model.fromJson(json['spO2'] as Map<String, dynamic>),
      bloodPressureModel: json['bloodPressure'] == null
          ? null
          : BloodPressureModel.fromJson(
              json['bloodPressure'] as Map<String, dynamic>),
      bloodSugarModel: json['bloodSugar'] == null
          ? null
          : BloodSugarModel.fromJson(
              json['bloodSugar'] as Map<String, dynamic>),
      bodyTemperatureModel: json['bodyTemperature'] == null
          ? null
          : TemperatureModel.fromJson(
              json['bodyTemperature'] as Map<String, dynamic>),
      type: json['sendAt'] as int?,
      notificationId: json['notificationId'] as String?,
      heading: json['heading'] as String?,
      content: json['content'] as String?,
      patientId: json['patientId'] as String?,
      patientName: json['patientName'] as String?,
      read: json['seen'] as bool?,
      sendDate: json['sendDate'] == null
          ? null
          : DateTime.parse(json['sendDate'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notificationId', instance.notificationId);
  writeNotNull('heading', instance.heading);
  writeNotNull('content', instance.content);
  writeNotNull('patientId', instance.patientId);
  writeNotNull('patientName', instance.patientName);
  writeNotNull('seen', instance.read);
  writeNotNull('sendAt', instance.type);
  writeNotNull('sendDate', instance.sendDate?.toIso8601String());
  writeNotNull('bloodPressure', instance.bloodPressureModel?.toJson());
  writeNotNull('bloodSugar', instance.bloodSugarModel?.toJson());
  writeNotNull('bodyTemperature', instance.bodyTemperatureModel?.toJson());
  writeNotNull('spO2', instance.spo2Model?.toJson());
  return val;
}

NotificationMetadata _$NotificationMetadataFromJson(
        Map<String, dynamic> json) =>
    NotificationMetadata();

Map<String, dynamic> _$NotificationMetadataToJson(
        NotificationMetadata instance) =>
    <String, dynamic>{};
