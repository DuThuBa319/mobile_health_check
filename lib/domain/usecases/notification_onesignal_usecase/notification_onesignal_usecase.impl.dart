part of 'notification_onesignal_usecase.dart';

@Injectable(
  as: NotificationUsecase,
)
class NotificationUsecaseImpl extends NotificationUsecase {
  final NotificationRepository _repository;

  NotificationUsecaseImpl(this._repository);

  @override
  Future<List<NotificationEntity>?> getNotificationListEntity(
      {required String? doctorId, int? startIndex, int? lastIndex}) async {
    final responses = await _repository.getNotificationListModels(
        doctorId: doctorId, startIndex: startIndex, lastIndex: lastIndex);
    final responseEntities = <NotificationEntity>[];
    for (final response in responses) {
      final entity = response.convertNotificationEntity();
      responseEntities.add(entity);
    }
    return responseEntities;
  }

  @override
  Future<void> setReadedNotificationEntity(String? notificationId) async {
    await _repository.setReadedNotificationModel(notificationId);
  }

  @override
  Future<void> deleteNotificationEntity(String? notificationId) async {
    await _repository.deleteNotificationModel(notificationId);
  }

  @override
  Future<NumberOfUnreadCountNotificationsEntity?> getUnreadCountNotificationEntity(String? doctorId) async {
    final respones = await _repository.getUnreadCountNotification(doctorId);
    final entity = respones.convertNumberOfUnreadCountNotificationEntity();
    return entity;
  }

  @override
  Future<NumberOfNotificationsEntity?> getNumberOfNotificationEntity(
      String? doctorId) async {
    final respones = await _repository.getNumberOfNotifications(doctorId);
    final entity = respones?.convertNumberOfNotificationsEntity();
    return entity;
  }
}
