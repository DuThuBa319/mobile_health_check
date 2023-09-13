import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../presentation/common_widget/dialog/show_toast.dart';

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
    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    // await  OneSignal.shared.setAppId("eb1e614e-54fe-4824-9c1a-aad236ec92d3");
    OneSignal.initialize("eb1e614e-54fe-4824-9c1a-aad236ec92d3");

    //Remove this method to stop OneSignal Debugging
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    final status = await Permission.notification.request();
    if (status.isDenied) {
      await Permission.notification.request();
      showToast("Bạn chưa bật cho phép thông báo");
      //SHOW DIALOG with 2 button => setting and cancel, if user press "setting" =>  final status = await OneSignal.Notifications.requestPermission(true);
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      //  await openAppSettings(); ==> nằm trong Dialog làm phía trên
    }

    OneSignal.User.pushSubscription.addObserver((state) {
      print(state.current.jsonRepresentation());
    });
    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission $state");
    });

//Hàm Phía Dưới triển khai khi có thông báo mới từ  OneSignal gửi đến

    //Hàm phía dưới triển khai khi nhấn vào POP-UP

    //  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    //   // will be called whenever the permission changes
    //   // (ie. user taps Allow on the permission prompt in iOS)
    //   if (changes.to.status != OSNotificationPermission.authorized) {
    //      OneSignal.shared.promptUserForPushNotificationPermission(
    //       fallbackToSettings: true,
    //     );
    //   }
    // });

    //  OneSignal.User.pushSubscription.addObserver((state) {

    // OneSignal.Notifications.permission; //!Kiểm tra xem có cấp quyền thông báo không

    //  await  OneSignal.Notifications.requestPermission(true); //!Nhắc cấp quyền thông báo
    //  await  OneSignal.Notifications.canRequest(); //!Kiểm tra xem lời nhắc quyền có thể được hiển thị hay không

    // });

    //log.i(text: 'Accepted Onesignal permission: $state');

    // await  OneSignal.shared
    //     .promptUserForPushNotificationPermission()
    //     .then((accepted) {});
  }

  // static Future<void> setUserId(String userId) async {
  //   if (kIsWeb) {
  //     return;
  //   }
  //   await  OneSignal.shared.setExternalUserId(userId);
  // }

  // static Future<void> setLanguage(String languageCode) async {
  //   if (kIsWeb) {
  //     return;
  //   }
  //   await  OneSignal.shared.setLanguage(languageCode);
  // }

  // static Future<void> removeUserId() async {
  //   if (kIsWeb) {
  //     return;
  //   }
  //   await  OneSignal.shared.removeExternalUserId();
  // }

  static Future<void> setTags(Map<String, dynamic> tags) {
    // return  OneSignal.shared.sendTags(tags);
    return OneSignal.User.addTags(tags);
  }

  static Future<void> deleteTags(List<String> keys) {
    // return  OneSignal.shared.deleteTags(keys);
    return OneSignal.User.removeTags(keys);
  }

  static void subscribeNotification({required String doctorId}) {
    //  OneSignal.shared.setExternalUserId(doctorId);
    OneSignal.login(doctorId);
    //  OneSignal.shared.sendTag("role", "doctor");
    OneSignal.User.addTagWithKey("role", "doctor");
    //  OneSignal.shared.sendTag("doctorId", doctorId);
    OneSignal.User.addTagWithKey("doctorId", doctorId);
    //  OneSignal.shared.sendTag('email', user.email);
    //  OneSignal.shared.sendTag('userId', user.id);
    //  OneSignal.shared.setExternalUserId("240914");
  }

  static void unsubscribeFromNotifications({required String doctorId}) {
    // Clear any tags and external user ID
    //  OneSignal.shared.deleteTags(["role", "doctorId"]);
    OneSignal.User.removeTags(["role", "doctorId"]);
    //  OneSignal.shared.removeExternalUserId();
    OneSignal.logout();
    // Unsubscribe the user from notifications
  }

  // static void unsubscribeNotification() {
  //    OneSignal.shared.removeExternalUserId();
  // }

  static void onNotificationOpened(
    void Function(OnNotificationClickListener listener) open,
  ) {
    OneSignal.Notifications.addClickListener(
      (event) => open,
    );
  }
  //change to  OneSignal.Notifications.addClickListener(_handleNotificationOpened)

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
  //       //kAppId is the App Id that one get from the  OneSignal When the application is registered.
  //       "android_channel_id": "e757239a-9b22-4630-9201-6bb51fd86a2f",
  //       "filters": [
  //         {"field": "tag", "key": "role", "relation": "=", "value": "doctor"},
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
