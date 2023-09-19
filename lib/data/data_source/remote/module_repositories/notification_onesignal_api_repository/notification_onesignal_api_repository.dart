import '../../../../models/notification_onesignal_model/notification_onesignal_model.dart';

abstract class NotificationApiRepository {
  Future<List<NotificationModel>> getNotificationListModels(String? doctorId);
  Future<void> setReadedNotificationModel(
  String? notificationId);
  Future<int?> getUnreadCountNotification(
      String? doctorId);
}
