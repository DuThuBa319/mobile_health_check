// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_onesignal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      patientName: json['patientName'] as String?,
      notificaitonId: json['notificaitonId'] as String?,
      heading: json['heading'] as String?,
      content: json['content'] as String?,
      patientId: json['patientId'] as String?,
      read: json['seen'] as bool?,
      sendDate: json['sendAt'] == null
          ? null
          : DateTime.parse(json['sendAt'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notificaitonId', instance.notificaitonId);
  writeNotNull('heading', instance.heading);
  writeNotNull('content', instance.content);
  writeNotNull('patientId', instance.patientId);
  writeNotNull('patientName', instance.patientName);
  writeNotNull('seen', instance.read);
  writeNotNull('sendAt', instance.sendDate?.toIso8601String());
  return val;
}

NotificationMetadata _$NotificationMetadataFromJson(
        Map<String, dynamic> json) =>
    NotificationMetadata();

Map<String, dynamic> _$NotificationMetadataToJson(
        NotificationMetadata instance) =>
    <String, dynamic>{};
