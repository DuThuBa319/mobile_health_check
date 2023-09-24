part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class GetNotificationListEvent extends NotificationEvent {
  // final List<NotificationEntity>? notificationEntiry;
  final String? doctorId;
  final int? startIndex;
  final int? lastIndex;
  GetNotificationListEvent(
      {required this.doctorId,
      required this.startIndex,
      required this.lastIndex});
}
class RenewPageAfterActionEvent extends NotificationEvent {
  // final List<NotificationEntity>? notificationEntiry;
  final String? doctorId;
  final int? startIndex;
  final int? lastIndex;
 RenewPageAfterActionEvent(
      {required this.doctorId,
      required this.startIndex,
      required this.lastIndex});
}


class RefreshNotificationListEvent extends NotificationEvent {
  // final List<NotificationEntity>? notificationEntiry;
  final String? doctorId;

  RefreshNotificationListEvent(
      {required this.doctorId,
    });
}

class SetReadedNotificationEvent extends NotificationEvent {
  final String? notificationId;
//  final String? doctorId;
//   final int? startIndex;
//   final int? lastIndex;
  SetReadedNotificationEvent({required this.notificationId
  // ,required this.doctorId,
  //     required this.startIndex,
  //     required this.lastIndex
      }) : super();
}

class DeleteNotificationEvent extends NotificationEvent {
  final String? notificationId;

  DeleteNotificationEvent({required this.notificationId}) : super();
}
