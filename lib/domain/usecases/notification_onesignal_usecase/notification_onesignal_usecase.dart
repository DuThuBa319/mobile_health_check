


import 'package:injectable/injectable.dart';

import '../../entities/notificaion_onesignal_entity.dart';
import '../../repositories/notification_onesignal_repository/notification_onesignal_repository.dart';

part 'notification_onesignal_usecase.impl.dart';

abstract class NotificationUsecase {
  Future<List<NotificationEntity>?> getNotificationListEntity(String? id);
  // Future<NotificationEntity> addNotificationEntity(NotificationModel Notification);
}

//Reppo chứa dữ liệu là list Notificationmodel thì usecase chứa list Notificationentity