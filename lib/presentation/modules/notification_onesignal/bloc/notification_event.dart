part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class GetNotificationListEvent extends NotificationEvent {
  // final List<NotificationEntity>? notificationEntiry;
  final String? id;

  GetNotificationListEvent({this.id});
}

class SetReadedNotificationEvent extends NotificationEvent {
  final String? notificationId;
  final NotificationModel notificationModel;

  SetReadedNotificationEvent(
      {required this.notificationId, required this.notificationModel})
      : super();
}
