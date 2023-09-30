import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/number_of_unread_count_notifications_entity.dart';

part 'number_of_unread_count_notifications_model.g.dart';

@JsonSerializable()
class NumberOfUnreadCountNotificationsModel {
  @JsonKey(name: "numberOfNotifications")
  int? numberOfUnreadCountNotifications;

  NumberOfUnreadCountNotificationsModel(this.numberOfUnreadCountNotifications);
  factory NumberOfUnreadCountNotificationsModel.fromJson(
          Map<String, dynamic> json) =>
      _$NumberOfUnreadCountNotificationsModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$NumberOfUnreadCountNotificationsModelToJson(this);

  NumberOfUnreadCountNotificationsEntity
      convertNumberOfUnreadCountNotificationEntity() {
    return NumberOfUnreadCountNotificationsEntity(
        numberOfUnreadCountNotifications: numberOfUnreadCountNotifications);
  }
}
