part of 'notification_onesignal_usecase.dart';

@Injectable(
  as: NotificationUsecase,
)
class NotificationUsecaseImpl extends NotificationUsecase {
  final NotificationRepository _repository;

  NotificationUsecaseImpl(this._repository);

  @override
  Future<List<NotificationEntity>?> getNotificationListEntity(
      {required String? userId, int? startIndex, int? lastIndex}) async {
    final responses = await _repository.getNotificationListModels(
        userId: userId, startIndex: startIndex, lastIndex: lastIndex);
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
  Future<int?> getUnreadCountNotificationEntity(String? userId) async {
    final respone = await _repository.getUnreadCountNotification(userId);

    return respone;
  }

  @override
  Future<int?> getNumberOfNotificationEntity(String? userId) async {
    final respone = await _repository.getNumberOfNotifications(userId);
    return respone;
  }
}
