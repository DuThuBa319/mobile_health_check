import '../base_datasource.dart';

abstract class NotificationDataSource extends BaseDataSource {
  // Future<String?> getToken();

  // Future<void> setToken(String token);

  int get unreadCount;

  // User? getUser();

  // Future<void> saveNotificationData(UserModel? user);
  Future<void> saveUnreadNotificationCount(int count);
  Future<void> increaseUnreadNotificationCount(); //Tăng số lượng unread,
  Future<void> decreaseUnreadNotificationCount();  //giảm số lượng unread
}