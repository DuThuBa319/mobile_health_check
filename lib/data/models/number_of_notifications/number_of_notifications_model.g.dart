// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_of_notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberOfNotificationsModel _$NumberOfNotificationsModelFromJson(
        Map<String, dynamic> json) =>
    NumberOfNotificationsModel(
      json['numberOfNotifications'] as int?,
    );

Map<String, dynamic> _$NumberOfNotificationsModelToJson(
    NumberOfNotificationsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('numberOfNotifications', instance.numberOfNotifications);
  return val;
}
