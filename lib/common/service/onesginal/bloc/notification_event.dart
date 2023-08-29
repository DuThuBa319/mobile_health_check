part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class IncreaseNotificationEvent extends NotificationEvent {
 final int? count;
  IncreaseNotificationEvent({this.count});
}

class DecreaseNotificationEvent extends NotificationEvent {
   final int? count;
  DecreaseNotificationEvent({this.count});
}
