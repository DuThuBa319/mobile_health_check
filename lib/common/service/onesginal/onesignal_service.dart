import 'dart:async';

import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
      await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    }
    await OneSignal.shared.setAppId("eb1e614e-54fe-4824-9c1a-aad236ec92d3");

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) async {
      // _inAppNotificationController.add(
      //   NotificationModel.fromJson(event.notification.additionalData ?? {}),
      // );
      // LogUtils.d(
      //   'Onesignal ShowInForeground ${event.notification.additionalData}',
      // );
      await notificationData.increaseUnreadNotificationCount();
      print('###${notificationData.unreadCount}');
      event.complete(event.notification);
    });
    OneSignal.shared.setNotificationOpenedHandler((openedResult) async {
      await notificationData.decreaseUnreadNotificationCount();
      print('###${notificationData.unreadCount}');
    });
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      if (changes.to.status != OSNotificationPermission.authorized) {
        OneSignal.shared.promptUserForPushNotificationPermission(
          fallbackToSettings: true,
        );
      }
    });

    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  static Future<void> setUserId(String userId) async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.shared.setExternalUserId(userId);
  }

  static Future<void> setLanguage(String languageCode) async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.shared.setLanguage(languageCode);
  }

  static Future<void> removeUserId() async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.shared.removeExternalUserId();
  }

  static Future<Map<String, dynamic>> setTags(Map<String, dynamic> tags) {
    return OneSignal.shared.sendTags(tags);
  }

  static Future<Map<String, dynamic>> deleteTags(List<String> keys) {
    return OneSignal.shared.deleteTags(keys);
  }

  static void subscribeNotification() {
    // if (user.id == null) {
    //   return;
    // }
    // OneSignal.shared.setExternalUserId(user.id!);
    // OneSignal.shared.sendTag('email', user.email);
    // OneSignal.shared.sendTag('userId', user.id);
    // OneSignal.shared.setExternalUserId("240914");
    OneSignal.shared.sendTag("role", "doctor");
    OneSignal.shared.sendTag("doctorId", "240914");
  }

  static void unsubscribeNotification() {
    OneSignal.shared.removeExternalUserId();
  }

  static void onNotificationOpened(
    void Function(OSNotificationOpenedResult) callback,
  ) {
    OneSignal.shared.setNotificationOpenedHandler(callback);
  }

  // static Future<Response> sendNotification(
  //     String contents, String heading) async {
  //   return await post(
  //     Uri.parse('https://onesignal.com/api/v1/notifications'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       "Authorization":
  //           "Basic <ZDViYWUzNGYtZjI3OS00N2Q3LWIwNDEtOWRjOGE3ZTQxOTVh"
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       "app_id": "eb1e614e-54fe-4824-9c1a-aad236ec92d3",
  //       // "target_channel": "push",
  //       // "isAndroid": true,
  //       //kAppId is the App Id that one get from the OneSignal When the application is registered.
  //       "android_channel_id": "e757239a-9b22-4630-9201-6bb51fd86a2f",
  //       "filters": [
  //         {"field": "tag", "key": "id", "relation": "=", "value": "240914"},
  //       ],
  //       // "include_player_ids":
  //       //     tokenIdList, //tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

  //       // android_accent_color reprsent the color of the heading text in the notifiction
  //       "android_accent_color": "FF9976D2",

  //       "small_icon": "ic_stat_onesignal_default",

  //       "large_icon":
  //           "https://www.filepicker.io/api/file/zPloHSmnQsix82nlj9Aj?filename=name.jpg",

  //       "headings": {"en": heading},

  //       "contents": {"en": contents},
  //     }),
  //   );
  // }
}
