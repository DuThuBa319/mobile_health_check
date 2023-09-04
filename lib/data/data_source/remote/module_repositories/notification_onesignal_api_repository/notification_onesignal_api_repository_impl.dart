
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';



import '../../../../models/notification_onesignal_model/notification_onesignal_model.dart';
import '../../rest_api_repository.dart';
import 'notification_onesignal_api_repository.dart';

@Injectable(as: NotificationApiRepository)
class NotificationApiRepositoryImpl implements NotificationApiRepository {
  final Dio dio;
  final RestApiRepository restApi;

  NotificationApiRepositoryImpl({
    required this.dio,
  }) : restApi = RestApiRepository(dio,
            baseUrl:
                'https://healthcareapplicationcloud.azurewebsites.net');

  @override
  Future<List<NotificationModel>> getNotificationListModels(String? id) {
    return restApi.getNotificationListModels(id);
  }
@override
  Future<void> setReadedNotificationModel(String? notificationId,NotificationModel? notificationModel) {
    return restApi.setReadedNotificationModel(notificationId,notificationModel);
  }
  // @override
  // Future<NotificationModel> registNotification(NotificationModel Notification) {
  //   return restApi.registNotification(Notification);
  // }

 
}
