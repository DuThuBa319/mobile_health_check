import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/number_of_notifications_entity.dart';

part 'number_of_notifications_model.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class NumberOfNotificationsModel {
  int? numberOfNotifications;

  NumberOfNotificationsModel(
   this.numberOfNotifications
  );
  factory NumberOfNotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$NumberOfNotificationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberOfNotificationsModelToJson(this);

  NumberOfNotificationsEntity convertNumberOfNotificationsEntity() {
    return NumberOfNotificationsEntity(numberOfNotifications: numberOfNotifications
     );
  }
}
