import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../di/di.dart';
import '../../../presentation/route/route_list.dart';
import '../navigation/navigation_service.dart';

// @Singleton()
// class OneSignalNotificationService {
//   OneSignalNotificationService._();

//   // final _inAppNotificationController =
//   //     StreamController<NotificationModel>.broadcast();

//   // Stream<NotificationModel> get onReceivedNotification =>
//   //     _inAppNotificationController.stream;

//   @factoryMethod
//   static Future<OneSignalNotificationService> create() async {
//     final instance = OneSignalNotificationService._();
//     await instance._init();
//     return instance;
//   }

//   Future<void> _init() async {
//     if (kDebugMode) {
//       await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//     }
//     await OneSignal.shared.setAppId("eb1e614e-54fe-4824-9c1a-aad236ec92d3");

// //Hàm Phía Dưới triển khai khi có thông báo mới từ OneSignal gửi đến

//     //Hàm phía dưới triển khai khi nhấn vào POP-UP

//     OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
//       // will be called whenever the permission changes
//       // (ie. user taps Allow on the permission prompt in iOS)
//       if (changes.to.status != OSNotificationPermission.authorized) {
//         OneSignal.shared.promptUserForPushNotificationPermission(
//           fallbackToSettings: true,
//         );
//       }
//     });

//     await OneSignal.shared
//         .promptUserForPushNotificationPermission()
//         .then((accepted) {});
//     OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
//       // setState(() {});
//       event.complete(event.notification);
//     });
//     OneSignal.shared.setNotificationOpenedHandler((openedResult) async {
//       await Future.delayed(const Duration(milliseconds: 3000));
//       injector<NavigationService>().navigateTo(RouteList.patientInfor,
//           argument: openedResult.notification.additionalData?["patientId"]);

//     });
//   }

//   static Future<void> setUserId(String userId) async {
//     if (kIsWeb) {
//       return;
//     }
//     await OneSignal.shared.setExternalUserId(userId);
//   }

//   static Future<void> setLanguage(String languageCode) async {
//     if (kIsWeb) {
//       return;
//     }
//     await OneSignal.shared.setLanguage(languageCode);
//   }

//   static Future<void> removeUserId() async {
//     if (kIsWeb) {
//       return;
//     }
//     await OneSignal.shared.removeExternalUserId();
//   }

//   static Future<Map<String, dynamic>> setTags(Map<String, dynamic> tags) {
//     return OneSignal.shared.sendTags(tags);
//   }

//   static Future<Map<String, dynamic>> deleteTags(List<String> keys) {
//     return OneSignal.shared.deleteTags(keys);
//   }

//   static void subscribeNotification({required String userId}) {
//     // if (user.id == null) {
//     //   return;
//     // }

//     OneSignal.shared.setExternalUserId(userId);
//     // OneSignal.shared.sendTag('email', user.email);
//     // OneSignal.shared.sendTag('userId', user.id);
//     // OneSignal.shared.setExternalUserId("240914");

//     OneSignal.shared.sendTag("role", "doctor");
//     OneSignal.shared.sendTag("doctorId", userId);
//   }

//   static void unsubscribeFromNotifications({required String doctorId}) {
//     // Clear any tags and external user ID
//     OneSignal.shared.deleteTags(["role", "doctorId"]);
//     OneSignal.shared.removeExternalUserId();

//     // Unsubscribe the user from notifications
//   }
// }

@Singleton()
class OneSignalNotificationService {
  OneSignalNotificationService._();

  // final _inAppNotificationController =
  //     StreamController<NotificationModel>.broadcast();

  // Stream<NotificationModel> get onReceivedNotification =>
  //     _inAppNotificationController.stream;

  @factoryMethod
  static Future<OneSignalNotificationService> create() async {
    final instance = OneSignalNotificationService._();
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    if (kDebugMode) {
      await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }
    OneSignal.initialize("eb1e614e-54fe-4824-9c1a-aad236ec92d3");

    OneSignal.Notifications.requestPermission(
        true); //!Hàm này yêu cầu người dùng cho phép ứng dụng gửi thông báo đẩy.
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      // setState(() {});
      event.preventDefault();
      event.notification.display();
    });
    OneSignal.Notifications.addClickListener((openedResult) async {
      await Future.delayed(const Duration(milliseconds: 2000));
      injector<NavigationService>().navigateTo(RouteList.patientInfor,
          argument: openedResult.notification.additionalData?["patientId"]);
    });
  }

  static Future<void> setUserId(String userId) async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.User.addAlias('doctor', userId);
  }

  static Future<void> setLanguage(String languageCode) async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.User.setLanguage(languageCode);
  }

  static Future<void> removeUserId() async {
    if (kIsWeb) {
      return;
    }
  }

  static void subscribeNotification({required String userId}) {
    // if (user.id == null) {
    //   return;
    // }

    OneSignal.User.addAlias('doctor', userId);
    // OneSignal.shared.sendTag('email', user.email);
    // OneSignal.shared.sendTag('userId', user.id);
    // OneSignal.shared.setExternalUserId("240914");

    OneSignal.User.addTags({"role": "doctor", "doctorId": userId});
  }

  static Future<void> unsubscribeFromNotifications(
      {required String doctorId}) async {
    // Clear any tags and external user ID
    await OneSignal.User.removeTags(["role", "doctorId"]);
    await OneSignal.User.removeAlias('doctor');

    // Unsubscribe the user from notifications
  }
}
