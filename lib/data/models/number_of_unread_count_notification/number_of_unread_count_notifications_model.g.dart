// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_of_unread_count_notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberOfUnreadCountNotificationsModel
    _$NumberOfUnreadCountNotificationsModelFromJson(
            Map<String, dynamic> json) =>
        NumberOfUnreadCountNotificationsModel(
          json['numberOfNotifications'] as int?,
        );

Map<String, dynamic> _$NumberOfUnreadCountNotificationsModelToJson(
    NumberOfUnreadCountNotificationsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'numberOfNotifications', instance.numberOfUnreadCountNotifications);
  return val;
}
