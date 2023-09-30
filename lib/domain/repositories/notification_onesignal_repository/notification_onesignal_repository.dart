//repo này gọi đến rôp rest_api trên kia

import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository.dart';
import '../../../data/models/notification_onesignal_model/notification_onesignal_model.dart';
import '../../../data/models/number_of_notifications/number_of_notifications_model.dart';
import '../../../data/models/number_of_unread_count_notification/number_of_unread_count_notifications_model.dart';

part 'notification_onesignal_repository.impl.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotificationListModels(
      {required String? doctorId, int? startIndex, int? lastIndex});
  Future<void> setReadedNotificationModel(String? notificationId);
  Future<NumberOfUnreadCountNotificationsModel> getUnreadCountNotification(String? doctorId);
  Future<NumberOfNotificationsModel?> getNumberOfNotifications(String? personId);

  Future<void> deleteNotificationModel(String? notificationId);

}
