import 'package:injectable/injectable.dart';

import '../../entities/notificaion_onesignal_entity.dart';
import '../../repositories/notification_onesignal_repository/notification_onesignal_repository.dart';

part 'notification_onesignal_usecase.impl.dart';

abstract class NotificationUsecase {
  Future<List<NotificationEntity>?> getNotificationListEntity(
      {required String? userId, int? startIndex, int? lastIndex});
  // Future<NotificationEntity> addNotificationEntity(NotificationModel Notification);
  Future<void> setReadedNotificationEntity(String? notificationId);
  Future<int?> getUnreadCountNotification(String? userId);
  Future<int?> getNumberOfNotification(String? userId);
  Future<void> deleteNotificationEntity(String? notificationId);
}

//Reppo chứa dữ liệu là list Notificationmodel thì usecase chứa list Notificationentity