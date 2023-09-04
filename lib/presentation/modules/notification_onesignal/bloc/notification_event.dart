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

  SetReadedNotificationEvent(
      {required this.notificationId})
      : super();
}
