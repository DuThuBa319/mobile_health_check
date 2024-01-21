import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/common/service/local_manager/notification_datasource/notification_datasource.dart';
import '../di/di.dart';
import 'service/firebase/firebase_auth_service.dart';
import 'service/local_manager/user_data_datasource/user_data_datasource.dart';
import 'service/navigation/navigation_service.dart';

FirebaseAuthService get firebaseAuthService => injector<FirebaseAuthService>();
UserDataDataSource get userDataData => injector<UserDataDataSource>();
NotificationDataSource get notificationData =>
    injector<NotificationDataSource>();
NavigationService get navigationService => injector<NavigationService>();
@lazySingleton
FToast get fToast {
  FToast fToast = FToast();
  fToast = fToast.init(navigationService.navigatorKey.currentContext!);
  return fToast;
}
