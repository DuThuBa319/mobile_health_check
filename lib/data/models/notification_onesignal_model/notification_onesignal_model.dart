import 'package:json_annotation/json_annotation.dart';

part 'notification_onesignal_model.g.dart';

@JsonSerializable()
class NotificationModel {
  String? notificaitonId;
  String? heading;
  String? content;
  String? patientId;
  String? patientName;
  @JsonKey(name: "seen")
  bool? read;
  @JsonKey(name: "sendAt")
  DateTime? sendDate;
  //NotificationMetadata? data;
  //LocalizationModel? contents;

  // @JsonKey(name: 'subject_type')
  // String? subjectType;
  // @JsonKey(name: 'subject_id')
  // String? subjectId;
  // @JsonKey(name: 'send_after')
  // DateTime? sendAfter;

  NotificationModel({
    this.notificaitonId,
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
}

@JsonSerializable()
class NotificationMetadata {
  NotificationMetadata();

  factory NotificationMetadata.fromJson(Map<String, dynamic> json) =>
      _$NotificationMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationMetadataToJson(this);
}
