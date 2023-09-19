import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


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

// Future<void> _init() async {
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

//   static void subscribeNotification({required String doctorId}) {
//     // if (user.id == null) {
//     //   return;
//     // }

//     OneSignal.shared.setExternalUserId(doctorId);
//     // OneSignal.shared.sendTag('email', user.email);
//     // OneSignal.shared.sendTag('userId', user.id);
//     // OneSignal.shared.setExternalUserId("240914");

//     OneSignal.shared.sendTag("role", "doctor");
//     OneSignal.shared.sendTag("doctorId", doctorId);
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

    // await  OneSignal.shared.setAppId("eb1e614e-54fe-4824-9c1a-aad236ec92d3");

    //Remove this method to stop OneSignal Debugging
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // final status = await Permission.notification.request();
    // if (status.isDenied) {
    //   await Permission.notification.request();
    //   showToast("Bạn chưa bật cho phép thông báo");
    //   //SHOW DIALOG with 2 button => setting and cancel, if user press "setting" =>  final status = await OneSignal.Notifications.requestPermission(true);
    //   // We didn't ask for permission yet or the permission has been denied before but not permanently.
    //   //  await openAppSettings(); ==> nằm trong Dialog làm phía trên
    // }

    // OneSignal.User.pushSubscription.addObserver((state) {
    //   print(state.current.jsonRepresentation());
    // });
    // OneSignal.Notifications.addPermissionObserver((state) {
    //   print("Has permission $state");
    // });

//Hàm Phía Dưới triển khai khi có thông báo mới từ  OneSignal gửi đến

    //Hàm phía dưới triển khai khi nhấn vào POP-UP

    // OneSignal.Notifications.addPermissionObserver((state) async {
    //   if (state == false) {
    //     OneSignal.Notifications.requestPermission(true);
    //   }
    // });
    
    OneSignal.Notifications.requestPermission(true); //!Hàm này yêu cầu người dùng cho phép ứng dụng gửi thông báo đẩy. 
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

  // static Future<Map<String, dynamic>> setTags(Map<String, dynamic> tags) {
  //   return OneSignal.shared.sendTags(tags);
  // }

  // static Future<Map<String, dynamic>> deleteTags(List<String> keys) {
  //   return OneSignal.shared.deleteTags(keys);
  // }

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
