// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_onesignal_repository.dart';

@Injectable(
  as: NotificationRepository,
)
class NotificationListRepositoryImpl extends NotificationRepository {
  final NotificationApiRepository _NotificationApi;

  NotificationListRepositoryImpl(
    this._NotificationApi,
  );
  @override
  Future<List<NotificationModel>> getNotificationListModels(String? id) {
    return _NotificationApi.getNotificationListModels(id);
  }

  // @override
  // Future<NotificationModel> addNotificationModel(NotificationModel Notification) {
  //   return _NotificationApi.registNotification(Notification);
  // }

 
}

//repo này chứa một cái list<NotificationModel>