part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class GetNotificationListEvent extends NotificationEvent {
  // final List<NotificationEntity>? notificationEntiry;
  final String? doctorId;
  final int startIndex;
  final int lastIndex;
  GetNotificationListEvent(
      {required this.doctorId,
      required this.startIndex,
      required this.lastIndex});
}

class RenewPageAfterActionEvent extends NotificationEvent {
  // final List<NotificationEntity>? notificationEntiry;
  final String doctorId;
  final int startIndex;
  final int lastIndex;
  RenewPageAfterActionEvent(
      {required this.doctorId,
      required this.startIndex,
      required this.lastIndex});
}

class RefreshNotificationListEvent extends NotificationEvent {
  final String? doctorId;

  RefreshNotificationListEvent({
    required this.doctorId,
  });
}

class SetReadedNotificationEvent extends NotificationEvent {
  final String? notificationId;

  SetReadedNotificationEvent({required this.notificationId}) : super();
}

class SetReadedNotificationFromCellEvent extends NotificationEvent {
  final int? index;
  final String? notificationId;

  SetReadedNotificationFromCellEvent(
      {required this.index, required this.notificationId})
      : super();
}

class DeleteNotificationEvent extends NotificationEvent {
  final String? notificationId;
  final int? index;
  DeleteNotificationEvent({required this.notificationId, required this.index})
      : super();
}
