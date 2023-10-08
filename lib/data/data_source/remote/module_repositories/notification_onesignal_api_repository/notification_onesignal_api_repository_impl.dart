import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../presentation/common_widget/enum_common.dart';
import '../../../../models/notification_onesignal_model/notification_onesignal_model.dart';
import '../../rest_api_repository.dart';
import 'notification_onesignal_api_repository.dart';

@Injectable(as: NotificationApiRepository)
class NotificationApiRepositoryImpl implements NotificationApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  NotificationApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio, baseUrl: baseUrl);

  @override
  Future<List<NotificationModel>> getNotificationListModels(
      {required String? userId, int? startIndex, int? lastIndex}) {
    return restApi.getNotificationListModels(
        personId: userId, startIndex: startIndex, lastIndex: lastIndex);
  }

  @override
  Future<void> setReadedNotificationModel(String? notificationId) {
    return restApi.setReadedNotificationModel(notificationId);
  }

  @override
  Future<int> getUnreadCountNotification(String? userId) {
    return restApi.getUnreadCountNotification(userId);
  }

  @override
  Future<int?> getNumberOfNotifications(String? userId) {
    return restApi.getNumberOfNotifications(userId);
  }

  @override
  Future<void> deleteNotificationModel(String? notificationId) {
    return restApi.deleteNotificationModel(notificationId);
  }
}
