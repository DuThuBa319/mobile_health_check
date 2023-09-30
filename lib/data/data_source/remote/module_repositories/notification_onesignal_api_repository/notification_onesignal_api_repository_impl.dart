import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/notification_onesignal_model/notification_onesignal_model.dart';
import '../../../../models/number_of_notifications/number_of_notifications_model.dart';
import '../../../../models/number_of_unread_count_notification/number_of_unread_count_notifications_model.dart';
import '../../rest_api_repository.dart';
import 'notification_onesignal_api_repository.dart';

@Injectable(as: NotificationApiRepository)
class NotificationApiRepositoryImpl implements NotificationApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  NotificationApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl: 'https://healthcareapplicationcloud.azurewebsites.net');

  @override
  Future<List<NotificationModel>> getNotificationListModels(
      {required String? doctorId, int? startIndex, int? lastIndex}) {
    return restApi.getNotificationListModels(
        personId: doctorId, startIndex: startIndex, lastIndex: lastIndex);
  }

  @override
  Future<void> setReadedNotificationModel(String? notificationId) {
    return restApi.setReadedNotificationModel(notificationId);
  }

  @override
  Future<NumberOfUnreadCountNotificationsModel> getUnreadCountNotification(String? doctorId) {
    return restApi.getUnreadCountNotification(doctorId);
  }

  @override
  Future<NumberOfNotificationsModel?> getNumberOfNotifications(
      String? doctorId) {
    return restApi.getNumberOfNotifications(doctorId);
  }

  @override
  Future<void> deleteNotificationModel(String? notificationId) {
    return restApi.deleteNotificationModel(notificationId);
  }

  // @override
  // Future<NotificationModel> registNotification(NotificationModel Notification) {
  //   return restApi.registNotification(Notification);
  // }
}
