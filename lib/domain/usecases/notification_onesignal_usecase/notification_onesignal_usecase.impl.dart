part of 'notification_onesignal_usecase.dart';

@Injectable(
  as: NotificationUsecase,
)
class NotificationUsecaseImpl extends NotificationUsecase {
  final NotificationRepository _repository;

  NotificationUsecaseImpl(this._repository);

  @override
  Future<List<NotificationEntity>?> getNotificationListEntity(
      String? id) async {
    final responses = await _repository.getNotificationListModels(id);
    final responseEntities = <NotificationEntity>[];
    for (final response in responses) {
      final entity = NotificationEntity(
        content: response.content,
        heading: response.heading,
        notificaitonId: response.notificaitonId,
        patientId: response.patientId,
        patientName: response.patientName,
        read: response.read,
        sendDate: response.sendDate,
      );
      responseEntities.add(entity);
    }

    return responseEntities;
  }

  @override
  Future<void> setReadedNotificationEntity(String? notificationId) async {
    await _repository.setReadedNotificationModel(notificationId);
  }

  @override
  Future<int?> getUnreadCountNotificationEntity(String? doctorId) async {
    return await _repository.getUnreadCountNotification(doctorId);
  }
}
