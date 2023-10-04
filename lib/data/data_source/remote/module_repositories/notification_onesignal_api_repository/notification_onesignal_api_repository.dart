import '../../../../models/notification_onesignal_model/notification_onesignal_model.dart';

abstract class NotificationApiRepository {
  Future<List<NotificationModel>> getNotificationListModels(
      {required String? userId, int? startIndex, int? lastIndex});
  Future<void> setReadedNotificationModel(String? notificationId);
  Future<int> getUnreadCountNotification(String? userId);
  Future<int?> getNumberOfNotifications(String? userId);
  Future<void> deleteNotificationModel(String? notificationId);
}
