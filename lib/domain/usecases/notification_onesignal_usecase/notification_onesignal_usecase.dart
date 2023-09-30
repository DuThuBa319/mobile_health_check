import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/number_of_notifications_entity.dart';
import 'package:mobile_health_check/domain/entities/number_of_unread_count_notifications_entity.dart';

import '../../entities/notificaion_onesignal_entity.dart';
import '../../repositories/notification_onesignal_repository/notification_onesignal_repository.dart';

part 'notification_onesignal_usecase.impl.dart';

abstract class NotificationUsecase {
  Future<List<NotificationEntity>?> getNotificationListEntity(
      {required String? doctorId, int? startIndex, int? lastIndex});
  // Future<NotificationEntity> addNotificationEntity(NotificationModel Notification);
  Future<void> setReadedNotificationEntity(String? notificationId);
  Future<NumberOfUnreadCountNotificationsEntity?>
      getUnreadCountNotificationEntity(String? doctorId);
  Future<NumberOfNotificationsEntity?> getNumberOfNotificationEntity(
      String? personId);
  Future<void> deleteNotificationEntity(String? notificationId);
}

//Reppo chứa dữ liệu là list Notificationmodel thì usecase chứa list Notificationentity