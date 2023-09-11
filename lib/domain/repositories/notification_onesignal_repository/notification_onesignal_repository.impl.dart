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
  Future<List<NotificationModel>> getNotificationListModels(String? id) {
    return _notificationApi.getNotificationListModels(id);
  }

  @override
  Future<void> setReadedNotificationModel(String? notificationId) {
    return _notificationApi.setReadedNotificationModel(notificationId);
  }

  @override
  Future<int?> getUnreadCountNotification(String? doctorId) {
    return _notificationApi.getUnreadCountNotification(doctorId);
  }
  // @override
  // Future<NotificationModel> addNotificationModel(NotificationModel Notification) {
  //   return _NotificationApi.registNotification(Notification);
  // }
}

//repo này chứa một cái list<NotificationModel>