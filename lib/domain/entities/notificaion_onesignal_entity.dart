class NotificationEntity {
  String? notificaitonId;
  String? heading;
  String? content;
  String? patientId;
  String? patientName;
  bool? read;
  DateTime? sendDate;

  NotificationEntity({
    this.patientName,
    this.notificaitonId,
    this.heading,
    this.content,
    this.patientId,
    this.read,
    this.sendDate,
  });
}
