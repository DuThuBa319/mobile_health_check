import '../../../../models/notification_onesignal_model/notification_onesignal_model.dart';
import '../../../../models/number_of_notifications/number_of_notifications_model.dart';
import '../../../../models/number_of_unread_count_notification/number_of_unread_count_notifications_model.dart';

abstract class NotificationApiRepository {
  Future<List<NotificationModel>> getNotificationListModels(
      {required String? doctorId, int? startIndex, int? lastIndex});
  Future<void> setReadedNotificationModel(String? notificationId);
  Future<NumberOfUnreadCountNotificationsModel> getUnreadCountNotification(
      String? doctorId);
  Future<NumberOfNotificationsModel?> getNumberOfNotifications(
      String? personId);
  Future<void> deleteNotificationModel(String? notificationId);
}
