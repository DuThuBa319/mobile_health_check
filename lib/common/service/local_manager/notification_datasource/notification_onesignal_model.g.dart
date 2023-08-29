// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_onesignal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      content: json['content'] as String?,
      heading: json['heading'] as String?,
      patientName: json['patientName'] as String?,
      read: json['read'] as bool?,
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

  writeNotNull('patientName', instance.patientName);
  writeNotNull('content', instance.content);
  writeNotNull('heading', instance.heading);
  writeNotNull('read', instance.read);
  writeNotNull('sendDate', instance.sendDate?.toIso8601String());
  return val;
}

NotificationMetadata _$NotificationMetadataFromJson(
        Map<String, dynamic> json) =>
    NotificationMetadata();

Map<String, dynamic> _$NotificationMetadataToJson(
        NotificationMetadata instance) =>
    <String, dynamic>{};
