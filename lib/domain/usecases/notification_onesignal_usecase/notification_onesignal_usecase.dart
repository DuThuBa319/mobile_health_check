import 'package:injectable/injectable.dart';

import '../../../data/models/notification_onesignal_model/notification_onesignal_model.dart';
import '../../entities/notificaion_onesignal_entity.dart';
import '../../repositories/notification_onesignal_repository/notification_onesignal_repository.dart';

part 'notification_onesignal_usecase.impl.dart';

abstract class NotificationUsecase {
  Future<List<NotificationEntity>?> getNotificationListEntity(String? id);
  // Future<NotificationEntity> addNotificationEntity(NotificationModel Notification);
  Future<void> setReadedNotificationEntity(
      String? notificationId);
}

//Reppo chứa dữ liệu là list Notificationmodel thì usecase chứa list Notificationentity