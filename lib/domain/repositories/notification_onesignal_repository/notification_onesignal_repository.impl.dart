// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_onesignal_repository.dart';

@Injectable(
  as: NotificationRepository,
)
class NotificationListRepositoryImpl extends NotificationRepository {
  final NotificationApiRepository _notificationApi;

  NotificationListRepositoryImpl(
    this._notificationApi,
  );
  @override
  Future<List<NotificationModel>> getNotificationListModels(
      {required String? userId, int? startIndex, int? lastIndex}) {
    return _notificationApi.getNotificationListModels(
        userId: userId, startIndex: startIndex, lastIndex: lastIndex);
  }

  @override
  Future<void> setReadedNotificationModel(String? notificationId) {
    return _notificationApi.setReadedNotificationModel(notificationId);
  }

  @override
  Future<void> deleteNotificationModel(String? notificationId) {
    return _notificationApi.deleteNotificationModel(notificationId);
  }

  @override
  Future<int?> getUnreadCountNotification(String? userId) {
    return _notificationApi.getUnreadCountNotification(userId);
  }

  @override
  Future<int?> getNumberOfNotifications(String? userId) {
    return _notificationApi.getNumberOfNotifications(userId);
  }
}

//repo này chứa một cái list<NotificationModel>