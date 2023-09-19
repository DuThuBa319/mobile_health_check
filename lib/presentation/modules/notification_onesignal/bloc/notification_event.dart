part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class GetNotificationListEvent extends NotificationEvent {
  // final List<NotificationEntity>? notificationEntiry;
  final String? doctorId;
  final int? startIndex;
  final int? lastIndex;
  GetNotificationListEvent({required this.doctorId,required this.startIndex,required this.lastIndex});
}

class SetReadedNotificationEvent extends NotificationEvent {
  final String? notificationId;

  SetReadedNotificationEvent({required this.notificationId}) : super();
}
