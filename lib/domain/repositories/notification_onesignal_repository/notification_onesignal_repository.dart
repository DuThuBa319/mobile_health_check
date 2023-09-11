//repo này gọi đến rôp rest_api trên kia

import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/notification_onesignal_api_repository/notification_onesignal_api_repository.dart';
import '../../../data/models/notification_onesignal_model/notification_onesignal_model.dart';

part 'notification_onesignal_repository.impl.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotificationListModels(String? id);
  Future<void> setReadedNotificationModel(String? notificationId);
  Future<int?> getUnreadCountNotification(String? doctorId);
}
